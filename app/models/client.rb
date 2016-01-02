class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  has_many :addrs, as: :addr_obj
  belongs_to :category, class_name: 'CodeTable'
  has_many :addresses, as: :addr_obj
  has_many :client_notes

  # tag
  acts_as_taggable
  acts_as_taggable_on :skills, :interests


  after_initialize do |client|
    # 载入交易
    @trades = Trade.where("client_id"=> self.id)
  end

  def contact_info
    if self.contacts.count > 0
      c = self.contacts.first
      "#{c.name}"
    else
      ''
    end
  end
  def addr_info
    if self.addresses.count > 0
      addr = self.addresses.first
      CodeTable.find(addr.province_id).name.to_s + ' ' + CodeTable.find(addr.city_id).name.to_s
    else
      ''
    end
  end

  def note
    # 获取所有的备注
    {'type'=>'info', 'msg'=>'提醒info'}
  end

  def join_days
    (DateTime.current - self.join_date.to_datetime).to_i.to_s + '天'
  end
  def trade_counts
    @trades.count.to_i
  end
  def trade_amounts
    @trades.sum('trade_amount').to_f
  end

  def last_trade_datetime
    last = @trades.order("trade_date").last
    if last
      last.trade_date.to_s
    else
      '无'
    end
  end

  def salesman_info
    Salesman.find(self.salesman_id.to_i)

  end
  def shop_category
    CodeTable.find(self.category_id)
  end

end
