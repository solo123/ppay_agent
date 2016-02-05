class ImpLog < ActiveRecord::Base
  has_many :imp_qf_clearings
  has_many :imp_qf_customers
  has_many :imp_qf_trades
  scope :show_order, -> { order(id: :desc) }
end
