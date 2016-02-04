class TradesController < ApplicationController

  def index
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    all_trades = agent_total.trades_all

    @all_data = search_trade(all_trades).order("trade_date DESC")
    @collection = @all_data.page( params[:page]).per(100)
    @detail_collection = []
    @collection.each do |t|
      @detail_collection << trade_detail(t)
    end
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
             "rate"=> client.rate, "amount"=> trade.trade_amount, "trade.status"=> trade.trade_result.name,
           }
    #
    # pos机编号
    if trade.pos_machine
     ret["pos_machine.number"] = trade.pos_machine.serial_number
     ret["pos_machine.url"] = pos_machine_path(trade.pos_machine)
    end
    return ret
  end

  def search_trade(trades)
    a = filter_suc(trades)
    b = filter_keyword(a)
    c = filter_type(b)
    d = filter_date(c)
    return d
  end

  def filter_keyword(trades)
    ret = trades
    if params[:search_t].nil? || params[:search_t].empty?
      return ret.order("trade_date DESC")
    end

    h = {
      'client_shid_eq'=> params[:search_t].to_i,
      'sub_account_cont'=> params[:search_t],
      'client_name_cont'=> params[:search_t],
      'client_shop_name_cont'=> params[:search_t],
      'm'=> 'or'
    }
    ret.ransack( h ).result.includes(:client)
  end

  def filter_suc(trades)
    suc_h = {
      'trade_result_name_cont'=> '交易成功'
    }
    trades.ransack( suc_h ).result.includes(:trade_result)
  end

  def filter_type(trades)
    ret = trades
    # 过滤 交易类型
    if params[:trade_type]!='' && params[:trade_type]!=nil
      ids = []
      params[:trade_type].each do |r|
        ids << CodeTable.ransack({'name_cont'=>r}).result.ids
      end
      ret = ret.where("trade_type_id"=>ids)
    end
    return ret
  end

  def filter_date(trades)
    ret = trades
    # 浏览器上传日期 '12/28/2015' 但是ruby可以解析的字符串格式为 'day/month/year' 例如 '28/12/2015'
    # 日期下限
    if params[:date_gt]!='' && params[:date_gt]!=nil
      d_gt_a = params[:date_gt].split('/')
      puts d_gt_a
      d_gt = Date.new(d_gt_a[2].to_i, d_gt_a[0].to_i,d_gt_a[1].to_i)
      ret = ret.where("trade_date > ?", d_gt)
    end
    # 日期上限
    if params[:date_lt]!='' && params[:date_lt]!=nil
      d_lt_a = params[:date_lt].split('/')
      puts d_lt_a
      d_lt = Date.new(d_lt_a[2].to_i, d_lt_a[0].to_i,d_lt_a[1].to_i)
      ret = ret.where("trade_date < ?", d_lt)
    end

    return ret
  end

end
