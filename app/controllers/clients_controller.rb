class ClientsController < ApplicationController
  respond_to :html, :js, :json
  def index
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)
    all_clients = agent_total.clients_all

    pages = $redis.get(:list_per_page) || 10
    @collection = filter_clients(all_clients).order("join_date DESC").page( params[:page] ).per(pages)

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
      'shid'=>r.shid,
      'shop_name'=>r.shop_name, "contact.name"=>c.name, 'contact.tel'=>c.tel,
      'addr'=> r.addr_info['province'] + ' ' + r.addr_info['city'], 'salesman'=>r.salesman.name, 'salesman.url'=>salesman_path(r.salesman),
      'qudao'=>'',
      'join_date'=>r.join_date, 'rate'=>r.rate,
      'client.url'=> client_url(r)
    }
  end

  def filter_clients(clients)
    if params[:search_t]=='' || params[:search_t]==nil
      return clients
    end

    q_hash = {
      'shop_name_cont'=> params[:search_t],
      'shop_tel_cont'=> params[:search_t],
      'contacts_name_cont'=> params[:search_t],
      'contacts_tel_cont'=> params[:search_t],
      # 'address_city_cont'=> params[:search_t],
      'm'=>'or'
    }
    # 特殊处理查询rate和shid,放在一起查询做eq的时候会越界
    if params[:search_t].include?("0.00")
      q_hash = {'rate_eq'=> params[:search_t]}
    end

    q = clients.ransack(  q_hash )
    tmp = q.result(distinct: true).includes(:contacts)


    return tmp
  end

end
