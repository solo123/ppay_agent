class Address < ActiveRecord::Base
  belongs_to :addr_obj, polymorphic: true
end