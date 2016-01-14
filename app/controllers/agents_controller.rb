class AgentsController < ResourcesController
  def create_login
    load_object
    # 创建代理商登录帐号
    c = Contact.find(params[:contact_id].to_i)

    u = User.find_or_create_by("mobile"=>c.tel, "name"=>c.name, 'email'=> c.tel + "@pooul.cn")
    if u
      u.password = c.tel
      u.agent = @object
      u.save
    end
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
    load_object
    if @object.company==nil
      c = Company.create
      @object.company = c
      @object.save
    end

    # 交易汇总
    @cur_trade_total = AgentDayTradetotal
            .select("sum(total_amount) as total_amount, sum(total_count) as total_count, sum(wechat_amount) as wechat_amount, sum(wechat_count) as wechat_count, sum(alipay_amount) as alipay_amount, sum(alipay_count) as alipay_count, sum(t0_amount) as t0_amount, sum(t0_count) as t0_count")
            .where("trade_date"=>Date.current.all_month, "agent_id"=> params[:id] )
            .group("id")
            .last
    #
    # 后调用super 暂时不知道原因
    super
  end

  private

end
