class Address < ActiveRecord::Base
  belongs_to :addr_obj, polymorphic: true
  belongs_to :province, class_name: 'CodeTable'
  belongs_to :city, class_name: 'CodeTable'
end
