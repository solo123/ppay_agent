class ClientDayTradetotalsController < ResourceController
  def month
    year = params[:q][0..3].to_i
    month = params[:q][4..6].to_i
    dt = Date.new(year, month, 1)
    @collection = ClientDayTradetotal.select("trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count").where(trade_date: (dt..dt.end_of_month)).group(:trade_date)
  end

  def active
    year = params[:q][0..3].to_i
    month = params[:q][4..6].to_i
    dt = Date.new(year, month, 1)
    order = params[:order] || "wechat_count"
    day_trade_total = ClientDayTradetotal.select("client_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where(trade_date: (dt..dt.end_of_month))
            .group(:trade_date).order("#{order} DESC")
    #
    @collection = []
    idx = 0
    day_trade_total.take(10).each do |t|
      idx += 1
      c = Client.find(t.client_id)

      if c.contacts.count==0
        c.contacts << Contact.new
        c.save
      end
      h = {}
      h["idx"] = idx
      h['shop_name'] = c.shop_name
      h["contact_name"] = c.contacts.last.name
      h["contact_tel"] = c.contacts.last.tel
      h["location"] = ''
      h['salesman.name'] = c.salesman.name
      h['salesman.url'] = salesman_path(c.salesman)
      h["qudao"] = ''
      h['join_date'] = c.join_date
      h["rate"] = c.rate
      h["total_amount"] = t.total_amount
      h["wechat_amount"] = t.wechat_amount
      h["wechat_count"] = t.wechat_count
      h["alipay_amount"] = t.alipay_amount
      h["alipay_count"] = t.alipay_count
      h["t0_amount"] = t.alipay_count
      h["t0_count"] = t.t0_count

      @collection << h
    end

  end
end
