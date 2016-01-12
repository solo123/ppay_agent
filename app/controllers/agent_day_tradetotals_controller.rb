class AgentDayTradetotalsController < ApplicationController

  # 针对平台统计出的活跃代理商
  def index

    year = params[:q][0..3].to_i
    month = params[:q][4..6].to_i
    dt = Date.new(year, month, 1)

    order = params[:order] || "wechat_count"
    day_trade_total = AgentDayTradetotal.select("agent_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where(trade_date: (Date.current.all_month))
            .group(:agent_id).order("#{order} DESC")
    #
    @collection = []
    idx = 0
    day_trade_total.each do |t|
      next if t.agent_id==nil || t.agent_id==0
      idx += 1
      agent = Agent.find(t.agent_id)
      user = agent.user || User.new
      h = {}
      h["idx"] = idx
      # h['shop_name'] = c.shop_name
      h["contact_name"] = user.name
      h["contact_tel"] = user.mobile
      h['cooperation_type'] = agent.cooperation_type_id
      h['cooperation_date'] = agent.cooperation_date
      h["salesman_count"] = agent.salesman_all.count
      h["client_count"] = agent.clients_all.count
      h["client_new_count"] = agent.new_clients.count

      # h["location"] = ''
      # h['salesman.name'] = c.salesman.name
      # h['salesman.url'] = salesman_path(c.salesman)
      h['trade_date'] = t.trade_date
      # 渠道名称	联系人	手机	合作时间	业务数	累计户	当月户

      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["alipay_count"] = t.alipay_count
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      @collection << h
    end

  end

  # 代理下的活跃商户和业务员
  def active_clients
    agent = Agent.find(params[:agent_id] || 1)
    d = params[:date] || Date.current
    order = params[:order] || "total_amount"

    @collection = agent.active_clients(d: Date.current, order: 'total_amount')
  end

  def active_salesmen
    agent = Agent.find(params[:agent_id] || 1)
    d = params[:date] || Date.current
    order = params[:order] || "total_amount"
    @collection = agent.active_salesmen(d: Date.current, order: 'total_amount')
  end
end
