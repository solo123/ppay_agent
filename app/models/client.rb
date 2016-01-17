class Client < ActiveRecord::Base
  belongs_to :salesman
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  belongs_to :category, class_name: 'CodeTable'
  has_many :addresses, as: :addr_obj
  has_many :client_notes
  has_many :client_day_tradetotals

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

  def note_info
    # 获取所有的备注
    {'type'=>'info', 'msg'=>'提醒info'}
  end

  def join_days
    (DateTime.current - self.join_date.to_datetime).to_i.to_s + '天'
  end

  def salesman_info
    Salesman.find(self.salesman_id.to_i)

  end
  def shop_category
    CodeTable.find(self.category_id)
  end

end
