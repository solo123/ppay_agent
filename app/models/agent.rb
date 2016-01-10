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

  # agent额外辅助信息计算
  def clients_total
    @clients = Client.where('salesman_id'=> self.salesman_ids).order('join_date ASC')
    @clients
  end
  def trades_total
    #商户的所有交易记录
    @trades = Trade.where('client'=> self.clients_total)
    @trades
  end
  def salesmen_total
    @salesmen = self.salesmen#Salesman.where("agent")
  end
  def contacts_total
    @contacts = Contact.take(10)
    @contacts
  end
  def clearings_total
    @clearings = Clearing.where("client_id"=>self.clients_total.ids)
    @clearings
  end
  def addresses_total
    @addresses = Address.where("client_id"=>self.clients_total.ids)
  end

  def new_clients
    self.clients_total.take(10)
  end

  def current_month_clients
    self.clients_total.where("join_date"=> Date.current.all_month)
  end

  def trade_groupby_client
    tmp = []
    alltrades = self.trades_total
    self.clients_total.all.each do |c|
      sum = alltrades.where('client_id'=>c.id).sum('trade_amount').to_f
      tmp << {"client"=> c, "sum"=> sum}
    end
    tmp
  end

  def active_clients
    # 规则: 最近两个月，交易数量>交易额 依次排序
    cur = Date.today
    last_info = self.trades_total.where("trade_date > #{Date.new(cur.year, cur.month-2, cur.day)}").group("client_id").take(10)
    clients = []
    last_info.each do |last|
      clients << last.client
    end
    clients
  end

end
