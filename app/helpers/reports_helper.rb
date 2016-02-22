module ReportsHelper
  def trade_value(objs, trade_type, attr)
    obj = objs.find{|t| t.trade_type == trade_type}
    if obj && obj.has_attribute?(attr)
      if attr == :amount
        n2 obj[attr]
      else
        n0 obj[attr]
      end
    else
      nil
    end
  end

  def trade_sum_month(trade_month, trade_type, field)
    ts = TradeSum.where(sum_obj_type: 'ALL', sum_type: 'month', trade_date: trade_month, trade_type: trade_type).first
    ts[field] if ts
  end
end
