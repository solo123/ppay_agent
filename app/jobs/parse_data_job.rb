class ParseDataJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::ParseDataBiz.new
    imp.parse_all
  end
end
