json.array!(@salesman_day_tradetotals) do |salesman_day_tradetotal|
  json.extract! salesman_day_tradetotal, :id, :trade_date, :total_amount, :total_count, :wechat_amount, :wechat_count, :alipay_amount, :alipay_count, :t0_amount, :t0_count, :t1_amount, :t1_count, :expected_amount, :actual_amount, :diff_amount, :diff_total_amount
  json.url salesman_day_tradetotal_url(salesman_day_tradetotal, format: :json)
end
