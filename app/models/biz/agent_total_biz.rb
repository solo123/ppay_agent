module Biz
  class AgentTotalBiz
    def initialize(agent_id)
      @agent = Agent.find(agent_id)
      salesman_all
      clients_all
      trades_all
    end
    def salesman_all
      @salesmen = @agent.salesmen
      @salesmen
    end
    def clients_all
      @clients = Client.where('salesman_id'=> self.salesman_all.ids)
      @clients
    end
    def trades_all
      @trades = Trade.where('client_id'=> self.clients_all.ids)
      @trades
    end
    def clearings_all
      @clearings = Clearing.where("client_id"=> self.clients_all.ids)
      @clearings
    end


    def active_clients
      sql = %Q{
        select
        client_id, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count
        from client_day_tradetotals
        where client_id in (
          select id from clients
          where salesman_id in (
	          select id from salesmen
	          where agent_id=#{@agent.id}
          )
        )
        group by client_id
        order by total_count DESC
      }
      tmp = ActiveRecord::Base.connection.execute(sql)[0]
      puts tmp
      @clients.take(10)

    end
    def active_salesmen
      # salesman_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count
      @salesmen.take(10)
    end
    def new_clients
      self.clients_all.order('join_date ASC').take(5)
    end
    def new_salesmen
      @salesmen.order('join_date ASC').take(5)
    end

    #trades info


    def trades_sum(dt)
      s_tuple= ''
      ids = self.clients_all.ids.each do |t|
        s_tuple << "#{t}, "
      end
      s_tuple << "0"

      sql = %Q{
        select
        sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count
        from client_day_tradetotals
        where client_day_tradetotals.trade_date between date '2015-12-01' and date '2015-12-31' and client_id in (#{s_tuple})
      }
      ActiveRecord::Base.connection.execute(sql)[0]
    end
  end
end
