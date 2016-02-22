module Biz
  class AdminBiz
    attr_accessor :errors
    @@flag_name = 'server_import_flag'

    def initialize
      @errors = []
      @parent_log = nil
    end

    def main_job
    end

    def log(title, detail = nil)
      log = Log.new
      log.log_title = title
      log.log_detail = detail
      log.level = 11
      log.parent = @parent_log
      log.save
      $redis.lpush(:server_log, title)
      log
    end
    def server_log(msg)
      puts msg
      $redis.lpush('server_log', msg)
    end
  end
end
