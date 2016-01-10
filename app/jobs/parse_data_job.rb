class ParseDataJob < ActiveJob::Base
  queue_as :default


  around_perform do |job, block|
    # do something before perform
    block.call
    # 生成统计表
    # TradesTotalsJob.perform_later nil
  end

  def perform(*args)
    imp = Biz::ParseDataBiz.new
    imp.parse_all
  end



end
