class Contact < ActiveRecord::Base
  has_many :addresses
  has_and_belongs_to_many :clients
  has_and_belongs_to_many :salesmen

end
