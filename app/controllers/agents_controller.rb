class AgentsController < ResourcesController
  def create_login
    # 创建代理商登录帐号
    c = Contact.find(params[:contact_id].to_i)

    u = User.find_or_create_by("mobile"=>c.tel, "name"=>c.name)
    if u
      u.password = c.tel
      u.save
    end
    @object.user = u
    @object.save

  end
  def del_salesman
    load_object
    s = Salesman.find(params[:salesman_id])
    s.agent = nil
    s.save
  end
  def add_salesman
    load_object
    s = Salesman.find(params[:salesman_id])
    @object.salesmen << s
    s.save
  end

  def show
    super
    # 交易汇总
    @cur_trade_total = AgentDayTradetotal.select("agent_id, trade_date, sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where("trade_date"=>Date.current.all_month)
    #
  end

  private

end
