class TradesTotalsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    imp = Biz::TradesTotalsBiz.new
    imp.statistics_all
  end
end
