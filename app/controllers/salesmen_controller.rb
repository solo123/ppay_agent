class SalesmenController < ApplicationController

  def index
    params[:q] ||= {}
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    all_salesman = agent_total.salesman_all
    @q = all_salesman.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 10
    @collection = @q.result(distinct: true).page(params[:page]).per( pages )

    @detail_collection = []
    @collection.each do |r|
      @detail_collection << salesman_detail(r)
    end

    @salesman_count = all_salesman.count
  end

  def show
    @object_hash = salesman_detail Salesman.find(params[:id])
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
    ret['url'] = salesman_path(salesman)
    return ret


  end
end
