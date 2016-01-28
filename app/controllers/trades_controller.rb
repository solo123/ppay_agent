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

    all_trades = agent_total.trades_all
    @q = all_trades.ransack( search_key )
    @collection = @q.result(distinct: true).page(params[:page]).per( 10 )
    @detail_collection = []

    @collection.each do |t|
      @detail_collection << trade_detail(t)
    end
    @trade_total_count = all_trades.count
    @trade_total_amount = all_trades.sum("trade_amount")

  end

  def show
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    @object = agent_total.trades_all.find( params[:id])
  end
  def trade_detail(trade)
    client = Client.find(trade.client_id)
    clearing_type = "T1"
    if client.rate == 0.70
      clearing_type = "T0"
    end
    ret = {"client.name"=> client.shop_name, "client.shid"=> client.shid, "client.url"=>client_path(client),
            "sub_accont.name"=> trade.sub_account,
            "trade_date"=> trade.trade_date.to_date, "trade_type"=> trade.trade_type.name, "clearing_type"=> clearing_type,
             "rate"=> client.rate, "amount"=> trade.trade_amount, "trade.status"=> "ok",
           }
  #
    if trade.pos_machine_id && trade.pos_machine_id > 0
     pos_machine  = PosMachine.find(trade.pos_machine_id)

     ret["pos_machine.number"] = pos_machine.serial_number
     ret["pos_machine.url"] = pos_machine_path(pos_machine)
    end
    return ret
  end

end
