class Agent < ActiveRecord::Base
  has_many :salesmen

  after_initialize do |agent|
    @salesmen_obj = self.salesmen # 获取所有的业务员
    @clients_obj = Client.where('salesman_id': @salesmen_obj.ids).order('join_date ASC') # 业务员下的所有商户
    @trades_obj = Trade.where('client_id': @clients_obj.ids) #商户的所有交易记录
  end
  def salesmen_obj
    @salesmen_obj
  end
  def clients_obj
    @clients_obj
  end
  def trades_obj
    @trades_obj
  end

  def new_clients
    @clients_obj.take(10)
  end

  def clients_trade
    tmp = []
    @clients_obj.all.each do |c|
      sum = Trade.where('client_id'=>c.id).sum('trade_amount').to_f
      tmp << {"client"=> c, "sum"=> sum}
    end
    tmp
  end

  def active_clients
    # 规则: 最近两个月，交易数量>交易额 依次排序
    last_info = @trades_obj.where("trade_date>2015-12-16").group("client_id").take(10)
    clients = []
    last_info.each do |last|
      clients << last.client
    end
    clients
  end


end
