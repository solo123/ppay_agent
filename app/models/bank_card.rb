class BankCard < ActiveRecord::Base
  belongs_to :bankcard_obj, polymorphic: true
end
