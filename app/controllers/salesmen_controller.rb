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
  end


end
