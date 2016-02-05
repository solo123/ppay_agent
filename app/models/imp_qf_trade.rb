class ImpQfTrade < ActiveRecord::Base
  belongs_to :imp_log
  scope :new_data, -> {where('zt is null or zt=0')}
  scope :show_order, -> {order('jyrq desc')}
end
