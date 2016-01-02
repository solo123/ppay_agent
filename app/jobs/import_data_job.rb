class ImportDataJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    imp = Biz::ImportBiz.new
    imp.import_from_email
  end
end
