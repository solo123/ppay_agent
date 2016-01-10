module Biz
  module TradeSum
    def self.month_sum_by(year, month)
      t = Date.new( year, month)
      # if t > Date.current | month > 12 | month==0 |
      #   return ''
      # end
      q_all = []
      for idx in 1..(t.all_month.last.day.to_i)
        q_all << Trade.where("trade_date LIKE ?", "%#{year}-#{month}-#{idx} %" )
      end
      q_all << Trade.where("trade_date LIKE ?", "%#{year}-#{month}-%" )
      # weichat_result = Trade.where("trade_type_id"=>75)

      tmp = []
      q_all.each do |q_result|
        weichat_result = q_result.where("trade_type_id"=>75)
        alipay_result = q_result.where('trade_type_id'=>78)

        rate_1 = 0.007
        t0_result = q_result.where("client_id"=>Client.where("rate"=>0.007).ids)

        tmp << {'amount_sum'=>q_result.sum('trade_amount'),
                'num_sum'=>q_result.count,
                'weichat_amount_sum'=>weichat_result.sum('trade_amount'),
                'weichat_num_sum'=>weichat_result.count,
                'alipay_amount_sum'=>alipay_result.sum("trade_amount"),
                'alipay_num_sum'=>alipay_result.count,
                't0_amount_sum'=>t0_result.sum("trade_amount"),
                't0_num_sum'=>t0_result.count
              }
      end
      tmp

    end
  end
end
