class ClientsController < ApplicationController
  respond_to :html, :js, :json
  
  def index
    params[:q] ||= {}
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    @q = agent_total.clients_all.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 100
    @collection = @q.result(distinct: true).includes(:contacts).page(params[:page]).per( pages )
  end

  def show
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    @object = agent_total.clients_all.find(params[:id])
    @trades = Trade.where("client_id"=> params[:id])
    @trades_for_pages = @trades.page( params[:page] ).per(20)
    c_total = Biz::ClientTotalBiz.new(params[:id])
    @total_info = c_total.trade_total
    @last_trade_datetime  = c_total.last_trade_datetime
  end

end
