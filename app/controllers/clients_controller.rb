class ClientsController < ApplicationController
  respond_to :html, :js, :json
  def index
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    @all_clients = agent_total.clients_all

    @collection = search_clients @all_clients

    @detail_collection = []
    @collection.each do |r|
      @detail_collection << detail_client(r)
    end
  end
  def show
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    @object = agent_total.clients_all.find(params[:id])
    @trades = Trade.where("client_id"=> params[:id])
    @trades_for_pages = @trades.page( params[:page] ).per(20)
    c_total = Biz::ClientTotalBiz.new(params[:id])
    @total_info = c_total.trade_total
    @last_trade_datetime  = c_total.last_trade_datetime
  end
  def detail_client(r)
    c = r.contacts.last
    addr = r.addresses.last

    addr_info = ""
    if addr!=nil
      province = CodeTable.find(addr.province_id).name
      city = CodeTable.find(addr.city_id).name
      addr_info = province + ' ' + city
    end

    s = r.salesman
    s_contact = nil
    if s.contact_id
      s_contact = Contact.find(s.contact_id)
    end
    {
      'shop_name'=>r.shop_name, "contact.name"=>c.name, 'contact.tel'=>c.tel,
      'addr'=> addr_info, 'salesman'=>r.salesman.name, 'salesman.url'=>salesman_path(r.salesman),
      'qudao'=>'',
      'join_date'=>r.join_date, 'rate'=>r.rate
    }
  end

  def search_clients(clients)
    q_hash = {
      'shop_name_cont'=> params[:search_t],
      'shop_tel_cont'=> params[:search_t],
      # 'rate_eq'=> params[:search_t],
      # 'id_eq'=> params[:search_t],
      'm'=>'or'
    }
    q = clients.ransack(  q_hash )
    pages = $redis.get(:list_per_page) || 10
    tmp = q.result(distinct: true).includes(:contacts).page(params[:page]).per( pages )

    # salesman_ids = Salesman.ransack({'name_cont'=> option['search_t']}).result(distinct: true).ids
    # r2 = collection.where("salesman_id"=> salesman_ids)
    # r1.ids | r2.ids

    return tmp
  end

end
