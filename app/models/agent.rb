class Agent < ActiveRecord::Base
  has_and_belongs_to_many :contacts
  belongs_to :company
  belongs_to :cooperation_type, class_name: 'CodeTable'
  belongs_to :user
  has_many :salesmen
  has_and_belongs_to_many :contacts

  has_many :bank_cards, as: :bankcard_obj
  has_many :agent_day_tradetotals
  has_many :sales_commissions, as: :sales_commission_obj


  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :bank_cards
  accepts_nested_attributes_for :sales_commissions
  accepts_nested_attributes_for :contacts


  # 统计数据 private
  def clients_all
    @clients = Client.where('salesman_id'=> self.salesman_all.ids)
    @clients
  end
  def trades_all
    @trades = Trade.where('client_id'=> self.clients_all.ids)
    @trades
  end
  def salesman_all
    self.salesmen
  end

  # 活跃数据
  def active_clients(d: Date.current, order: 'total_amount')

    all_data = ClientDayTradetotal.where("client_id"=>self.clients_all.ids, "trade_date"=>d.all_month)
            .select("client_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .group(:client_id).order("#{order} DESC")
    #
    # all_data = ClientDayTradetotal.select("client_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
    #         .where(trade_date: (d.all_month))
    #         .group(:trade_date).order("#{order} DESC")



    collection = []
    idx = 0

    all_data.each do |t|
      idx += 1
      c = Client.find(t.client_id)
      contact = Contact.new
      if c.contacts.count>0
        contact = c.contacts.last
      end

      h = {}
      h["idx"] = idx
      h['shop_name'] = c.shop_name
      h["contact_name"] = contact.name
      h["contact_tel"] = contact.tel
      h["location"] = ''
      h['salesman.name'] = c.salesman.name
      h['salesman.url'] = c.salesman
      h["qudao"] = ''
      h['join_date'] = c.join_date
      h["rate"] = c.rate
      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["alipay_count"] = t.alipay_count
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      collection << h
    end

    return collection
  end


  def active_salesmen(d: Date.current, order: 'total_amount')

    all_data = SalesmanDayTradetotal.where("salesman_id"=>self.salesman_all.ids, "trade_date"=>d.all_month)
            .select("salesman_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .group(:salesman_id).order("#{order} DESC")
    #
    collection = []
    idx = 0

    all_data.each do |t|
      idx += 1
      s = Salesman.find(t.salesman_id)


      h = {}
      h["idx"] = idx
      h["contact_name"] = ''
      h["contact_tel"] = ''

      h['clienter.count'] = s.clients_all.count
      h["clienter.new"] = s.new_clients.count

      h["trade_date"]  = t.trade_date
      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["alipay_count"] = t.alipay_count
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      collection << h
    end
    return collection

  end

  def new_clients
    self.clients_all.order('join_date ASC').take(20)
  end

  # 当月交易统计
  # 交易汇总
  def cur_trade_total
    cur_trade_total = AgentDayTradetotal.select("agent_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where("trade_date"=>Date.current.all_month, "agent_id"=>self.id)
    #
    cur_trade_total.last
  end



end
