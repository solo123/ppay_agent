module Biz
  class TradesTotalsBiz < AdminBiz
    def main_job
      return if $redis.get(@@flag_name) == 'running'
      $redis.set(@@flag_name, 'running')
      total_clients_salesmen_agents
      $redis.set(@@flag_name, '')
    end

    def total_clients_salesmen_agents
      success_trade_code = CodeTable.find_code('trade_result', '交易成功').id
      Trade.where('status < 2 and trade_result_id = ?', success_trade_code).each do |t|
        td = t.trade_date.to_date.to_s
        tt = trade_type(t)
        am = t.trade_amount
        add_sum(am, nil, tt, td)
        add_sum(am, t.client, tt, td)
        if t.client.salesman
          sm = t.client.salesman
          add_sum(am, sm, tt, td)
          if sm.agent
            ag = sm.agent
            add_sum(am, ag, tt, td)
          end
        end
        t.status = 2
        t.save
        server_log "#{t.id}, #{am}, #{tt}, #{td}"
      end
    end

    def add_sum(amount, sum_obj, trade_type, trade_date)
      trade_month = trade_date[0..6]
      add_sum1(amount, sum_obj, trade_type, trade_date, 'day')
      add_sum1(amount, sum_obj, 'all', trade_date, 'day')
      add_sum1(amount, sum_obj, trade_type, trade_month, 'month')
      add_sum1(amount, sum_obj, 'all', trade_month, 'month')
    end
    def add_sum1(amount, sum_obj, trade_type, trade_date, sum_type)
      s = nil
      if sum_obj
        s = TradeSum.find_or_create_by(sum_obj: sum_obj, trade_type: trade_type, sum_type: sum_type, trade_date: trade_date)
      else
        s = TradeSum.find_or_create_by(sum_obj_type: 'ALL', trade_type: trade_type, sum_type: sum_type, trade_date: trade_date)
      end
      s.amount += amount
      s.count += 1
      s.save
    end
    def clear_totals
      TradeSum.delete_all
      Trade.update_all(status: 0)
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
