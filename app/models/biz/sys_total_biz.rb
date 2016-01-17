module Biz
  class SysTotalBiz
    def self.active_agents(dt, order='total_amount')
      d = dt.all_month
      sql = %Q{
        select
          agent_id,
          sum(total_amount) as total_amount,
          sum(total_count) as total_count,
          sum(wechat_amount) as wechat_amount,
          sum(wechat_count) as wechat_count,
          sum(alipay_amount) as alipay_amount,
          sum(alipay_count) as alipay_count,
          sum(t0_amount) as t0_amount,
          sum(t0_count) as t0_count
        from salesmen, agents, clients, client_day_tradetotals
        where
          salesmen.agent_id=agents.id and clients.salesman_id=salesmen.id
          and client_day_tradetotals.client_id=clients.id
          and client_day_tradetotals.trade_date between date '#{d.first.to_s}' and date '#{d.last.to_s}'
        group by agent_id
        order by #{order} DESC
      }
      ActiveRecord::Base.connection.execute(sql).take 10

    end

    def self.active_clients(dt, order='total_amount')
      d = dt.all_month
      sql = %Q{
        select
          client_id,
          sum(total_amount) as total_amount,
          sum(total_count) as total_count,
          sum(wechat_amount) as wechat_amount,
          sum(wechat_count) as wechat_count,
          sum(alipay_amount) as alipay_amount,
          sum(alipay_count) as alipay_count,
          sum(t0_amount) as t0_amount,
          sum(t0_count) as t0_count
        from salesmen, agents, clients, client_day_tradetotals
        where
          client_day_tradetotals.trade_date between date '#{d.first.to_s}' and date '#{d.last.to_s}'
        group by client_id
        order by #{order} DESC
      }
      ActiveRecord::Base.connection.execute(sql).take 10

    end

  end
end
