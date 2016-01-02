class ImpLog < ActiveRecord::Base
  has_many :imp_qf_clearings
  has_many :imp_qf_customers
  has_many :imp_qf_trades
  default_scope { order(id: :desc) }
end
