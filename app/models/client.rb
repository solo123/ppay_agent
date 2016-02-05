class Client < ActiveRecord::Base
  belongs_to :salesman
  belongs_to :main_contact, class_name: 'Contact'
  has_and_belongs_to_many :contacts
  has_many :pos_machines
  belongs_to :category, class_name: 'CodeTable'
  belongs_to :address
  has_many :client_notes
  has_many :client_day_tradetotals
  has_many :trades

  # tag
  acts_as_taggable
  acts_as_taggable_on :skills, :interests

  scope :show_order, -> {order('join_date desc')}

  def self.update_main_contacts
    Client.where(main_contact: nil).each do |c|
      unless c.contacts.empty?
        c.main_contact = c.contacts.first
        c.save
      end
    end
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
    if self.address
      "#{self.address.province.name} #{self.address.city.name} #{self.address.street}"
    else
      ''
    end
  end
  def area_info
    if self.address
      "#{self.address.province.name} #{self.address.city.name}"
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
end
