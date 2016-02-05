class ImpQfCustomer < ActiveRecord::Base
  belongs_to :imp_log
  scope :new_data, -> {where('zt is null or zt=0')}
end
