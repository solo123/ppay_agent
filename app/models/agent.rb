class Agent < ActiveRecord::Base
  has_and_belongs_to_many :contacts
  belongs_to :company
  belongs_to :cooperation_type, class_name: 'CodeTable'
  has_many :salesmen

  has_many :bank_cards, as: :bankcard_obj
  has_many :agent_day_tradetotals
  has_many :sales_commissions, as: :sales_commission_obj


  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :bank_cards
  accepts_nested_attributes_for :sales_commissions
  accepts_nested_attributes_for :contacts

end
