class SalesmanDayTradetotalsController < ResourceController
  def show
    year = params[:id][0..3].to_i
    month = params[:id][4..6].to_i
    dt = Date.new(year, month, 1)
    @collection = SalesmanDayTradetotal.select("trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count").where(trade_date: (dt..dt.end_of_month)).group(:trade_date)
  end
end
