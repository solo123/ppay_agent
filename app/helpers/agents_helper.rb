module AgentsHelper
  def agent_sum_month(agent, trade_month, trade_type, field)
    ts = TradeSum.where(sum_obj: agent, sum_type: 'month', trade_date: trade_month, trade_type: trade_type).first
    ts[field] if ts
  end
end
