class ReportsController < ApplicationController
  def clients_days
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @prev_month = dt - 1.month
    @next_month = dt + 1.month
    @collection = ClientDayTradetotal.select(%Q(
    trade_date,
    sum(total_amount) as total_amount,
    sum(total_count) as total_count,
    sum(wechat_amount) as wechat_amount,
    sum(wechat_count) as wechat_count,
    sum(alipay_amount) as alipay_amount,
    sum(alipay_count) as alipay_count,
    sum(t0_amount) as t0_amount,
    sum(t0_count) as t0_count,
    sum(t1_amount) as t1_amount,
    sum(t1_count) as t1_count
    )).where(trade_date: dt.all_month).group(:trade_date).order("trade_date ASC")

    keys = ['total_amount', 'total_count', 'wechat_amount', 'wechat_count', 'alipay_amount', 'alipay_count', 't0_amount', 't0_count' ]

    tmp = ClientDayTradetotal.where("trade_date"=>dt.all_month)
    @total_sums = {}
    keys.each do |k|
      @total_sums[k] = tmp.sum(k).to_f
    end

  end

  def new_clients
    @collection = Client.order("join_date DESC").take(10)
  end

  def active_clients
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @collection_clients = []
    idx = 0
    all = Biz::SysTotalBiz.active_clients(dt, 'total_amount')
    all.each do |t|
      idx += 1
      client = Client.find(t["client_id"])
      c = client.contacts.first
      # total = Biz::AgentTotalBiz.new(client.id)
      t["idx"] = idx
      if c
        t["contact_name"] = c.name || ''
        t["contact_tel"] = c.tel || ''
      end
      # # t['cooperation_type'] = agent.cooperation_type_id
      # t['cooperation_date'] = agent.cooperation_date
      # t["salesman_count"] = total.salesman_all.count
      # t["client_count"] = total.clients_all.count
      # t["client_new_count"] = total.new_clients.count

      t["location"] = ''
      @collection_clients << t
    end
  end

  def active_agents
    year = params[:q][0..3].to_i
    month = params[:q][5..7].to_i
    dt = Date.new(year, month, 1)
    @collection_agents = []
    idx = 0
    all = Biz::SysTotalBiz.active_agents(dt, 'total_amount')
    all.each do |t|
      idx += 1
      agent = Agent.find(t["agent_id"])
      c = agent.contacts.first
      total = Biz::AgentTotalBiz.new(agent.id)
      t["idx"] = idx
      if c
        t["contact_name"] = c.name || ''
        t["contact_tel"] = c.tel || ''
      end
      t['cooperation_type'] = agent.cooperation_type_id
      t['cooperation_date'] = agent.cooperation_date
      t["salesman_count"] = total.salesman_all.count
      t["client_count"] = total.clients_all.count
      t["client_new_count"] = total.new_clients.count

      t["location"] = ''
      @collection_agents << t
    end
  end
end
