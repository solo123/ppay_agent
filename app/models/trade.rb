class Trade < ActiveRecord::Base
  belongs_to :client
  belongs_to :pos_machine
  belongs_to :trade_type, class_name: 'CodeTable'
  belongs_to :trade_result, class_name: 'CodeTable'
  scope :show_order, -> {order('trade_date desc')}
end
