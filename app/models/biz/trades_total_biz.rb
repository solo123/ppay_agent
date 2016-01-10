module Biz
  class TradesTotalBiz

    @@sum_field = ['total_amount', 'total_count',
                'wechat_amount', 'wechat_count', 'alipay_amount', 'alipay_count',
                't0_amount', 't0_count', 't1_amount', 't1_count']
    #

    def total_all
      total_clients
      total_salesmen
      total_agents
    end

    def total_clients
      Trade.all.each do |t|
        c_total = ClientDayTradetotal.find_or_create_by(client_id: t.client_id, trade_date: t.trade_date )
        puts c_total.client_id
        puts t.trade_amount
        puts c_total.total_amount
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
      ClientDayTradetotal.all.each do |t|
        s_day = SalesmanDayTradetotal.find_or_create_by(salesman_id: t.client.salesman_id, trade_date: t.trade_date )
        @@sum_field.each do |field|
          s_day[field] += t[field]
        end
        s_day.save
      end
    end


    def total_agents
      SalesmanDayTradetotal.all.each do |t|
        a_day = AgentDayTradetotal.find_or_create_by(agent_id: t.salesman.agent_id, trade_date: t.trade_date )
        @@sum_field.each do |field|
          a_day[field] += t[field]
        end
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

  end
end
