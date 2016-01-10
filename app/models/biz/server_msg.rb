module Biz
  class ServerMsg
    def initialize(log_name)
      @log_name = log_name
    end
    def log(message)
      $redis.lpush @log_name, message
    end
    def get_msg
      $redis.rpop @log_name
    end
  end
end
