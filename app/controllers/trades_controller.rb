class TradesController < ApplicationController

  def index
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    params[:q] ||= {}
    params[:all_query] ||= ''
    search_key = params[:q]

    if !params[:all_query].to_s.empty?
      search_key  =  {'m'=>'or'}
      search_key["trade_amount_eq"] = params[:all_query].to_f
      search_key["trade_date"] = params[:all_query].to_date || Date.current
    end
    @q = agent_total.trades_all.ransack( search_key )

    @collection = @q.result(distinct: true).page(params[:page]).per( 100 )
  end

  def show
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    @object = agent_total.trades_all.find( params[:id])
  end

end
