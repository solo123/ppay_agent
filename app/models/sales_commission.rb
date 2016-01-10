class SalesCommission < ActiveRecord::Base
  belongs_to :sales_commission_obj, polymorphic: true
end
