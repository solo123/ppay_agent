class SalesmenController < ApplicationController
  def initialize
    super
    @table_head = '业务员资料'
    @fields = %w(name)
    @field_titles = [ '姓名' ]
  end

  def index
    params[:q] ||= {}
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    @q = agent_total.salesman_all.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).page(params[:page]).per( pages )

    @detail_collection = []
    @collection.each do |r|
      @detail_collection << salesman_detail(r)
    end
  end

  def salesman_detail(salesman)
    ret = {
      "contact.name"=>salesman.name, 'contact.tel'=>'', 'join_date'=>Date.current,
      'status'=>'正常'
    }
    if salesman.contact_id
        contact = Contact.find(salesman.contact_id)
        ret['conact.name'] = contact.name if contact.name
        ret['conact.tel'] = contact.name if contact.tel
    end
    return ret


  end
end
