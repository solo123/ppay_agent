class AgentDayTradetotalsController < ResourceController

  def active
    year = params[:q][0..3].to_i
    month = params[:q][4..6].to_i
    dt = Date.new(year, month, 1)
    day_trade_total = AgentDayTradetotal.select("agent_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where(trade_date: (dt..dt.end_of_month))
            .group(:trade_date).order("total_amount DESC")
    #
    @collection = []
    idx = 0
    day_trade_total.take(10).each do |t|
      # next if t.agent_id==nil
      agent = Agent.find(1)

      idx += 1
      h = {}
      h["idx"] = idx
      h["name"] = agent.name
      h["contact_name"] = agent.name
      h["cooperation_date"] = agent.cooperation_date
      h['salesman.count'] = agent.salesmen.count
      h['clienter.count'] = agent.clients.count
      h["clienter.new"] = agent.current_month_clients.count
      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      @collection << h
    end
  end
end
