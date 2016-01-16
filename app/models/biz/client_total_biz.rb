module Biz
  class ClientTotalBiz
    def initialize(client_id)
      @client = Client.find(client_id)
    end

    def trade_total
      sql = %Q{
        select
          sum("total_amount") as total_amount,
          sum("total_count") as total_count,
          sum("wechat_amount") as wechat_amount,
          sum("wechat_count") as wechat_count,
          sum("t0_amount") as t0_amount,
          sum("t0_count") as t0_count
        from client_day_tradetotals
        where client_id=#{@client.id}
        }
      ActiveRecord::Base.connection.execute(sql)[0]
    end
    def last_trade_datetime
      t = Trade.where(client_id: @client.id).order("trade_date DESC")
      if t.count>0
        return t.first.trade_date.to_date.to_s
      else
        return 0
      end
    end

  end
end
