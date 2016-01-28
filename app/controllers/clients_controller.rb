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
    @trades_detail = []
    @trades_for_pages.each do |r|
      @trades_detail << detail_trade(r)
    end

    c_total = Biz::ClientTotalBiz.new(params[:id])
    @total_info = c_total.trade_total
    @last_trade_datetime  = c_total.last_trade_datetime

  end


  def detail_trade(r)

    pos = PosMachine.find(1)
    type = CodeTable.find(r.trade_type_id)
    result = CodeTable.find(r.trade_result_id)
    pos_num = ''
    if pos
      pos_num = pos.serial_number
    end



    {
      "trade.trade_date"=> r.trade_date.strftime("%Y-%m-%d %H:%M:%S"),
      "trade.trade_amount"=> r.trade_amount,
      "trade.type"=> type.name,
      "trade.result"=> result.name,
      "trade.pos_machine"=> pos_num,
    }

  end
  def detail_client(r)
    c = r.contacts.last

    s = r.salesman
    s_contact = nil
    if s.contact_id
      s_contact = Contact.find(s.contact_id)
    end
    {
      'shop_name'=>r.shop_name, "contact.name"=>c.name, 'contact.tel'=>c.tel,
      'addr'=> r.addr_info, 'salesman'=>r.salesman.name, 'salesman.url'=>salesman_path(r.salesman),
      'qudao'=>'',
      'join_date'=>r.join_date, 'rate'=>r.rate,
      'client.url'=> client_url(r)

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
