class Company < ActiveRecord::Base
  belongs_to :address
  belongs_to :company_obj, polymorphic: true

  accepts_nested_attributes_for :address
end
