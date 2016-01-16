module Biz
  class TradesTotalsBiz
    @@sum_field = ['total_amount', 'total_count',
                'wechat_amount', 'wechat_count', 'alipay_amount', 'alipay_count',
                't0_amount', 't0_count', 't1_amount', 't1_count']

    def total_all
      $redis.set(:trades_totals_flag, 'running')
      total_clients
      total_salesmen
      total_agents
      slog('import_end')
      $redis.set(:trades_totals_flag, '')
    end

    def total_clients
      Trade.where("status"=>0).each do |t|
        # Trade.trade_date数据格式:DateTime  ClientDayTradetotal.trade_date数据格式:Date
        # 必须先转换格式 交由数据库转换格式会出错
        c_total = ClientDayTradetotal.find_or_create_by(client_id: t.client_id, trade_date: t.trade_date.to_date )

        c_total.total_amount += t.trade_amount
        c_total.total_count += 1
        type_code = trade_type(t)
        c_total["#{type_code}_amount"] += t.trade_amount
        c_total["#{type_code}_count"] += 1

        t.status = 1
        t.save
        c_total.save
      end
    end

    def total_salesmen
      ClientDayTradetotal.where("status"=>0).each do |t|
        s_day = SalesmanDayTradetotal.find_or_create_by(salesman_id: t.client.salesman_id, trade_date: t.trade_date )
        @@sum_field.each do |field|
          s_day[field] += t[field]
        end
        t.status = 1
        t.save
        s_day.save
      end
    end


    def total_agents
      SalesmanDayTradetotal.where("status"=>0).each do |t|
        a_day = AgentDayTradetotal.find_or_create_by(agent_id: t.salesman.agent_id, trade_date: t.trade_date )
        @@sum_field.each do |field|
          a_day[field] += t[field]
        end
        t.status = 1
        t.save
        a_day.save
      end
    end

    def trade_type(trade)
      re_type_code = nil
      if trade.trade_type.name.include?('微信')
        re_type_code = 'wechat'
      elsif trade.trade_type.name.include?("支")
         re_type_code = 'alipay'
      else
        # 根据client确定t0/t1
        re_type_code =  trade.client.rate == 0.007 ? 't0' : 't1'

      end
      return re_type_code

    end
    def slog(msg)
      puts msg
      $redis.lpush(:trades_totals_log, msg)
    end

  end
end
