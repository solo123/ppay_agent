class ImportDataJob < ActiveJob::Base
  queue_as :default

  around_perform do |job, block|
    # do something before perform
    block.call
    # 导入完成后自动解析数据到业务表
    # ParseDataJob.perform_later nil
  end

  def perform(*args)
    imp = Biz::ImportBiz.new
    imp.import_from_email
  end
end
