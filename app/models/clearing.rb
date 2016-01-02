class Clearing < ActiveRecord::Base
  belongs_to :client
  belongs_to :clearing_status, class_name: 'CodeTable'
end
