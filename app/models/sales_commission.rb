class SalesCommission < ActiveRecord::Base
  belongs_to :sales_commission_obj, polymorphic: true

  has_and_belongs_to_many :agents

end
