class ClientsController < ApplicationController
  respond_to :html, :js, :json

  def index
    params[:q] ||= {}
    agent_total  = Biz::AgentTotalBiz.new(current_user.agent.id)

    @q = agent_total.clients_all.ransack( params[:q] )
    pages = $redis.get(:list_per_page) || 100
    tmp = @q.result(distinct: true).includes(:contacts).page(params[:page]).per( pages )
    @collection = search_clients(tmp, {'search_t'=>params[:search_t], 'channel_n'=>params[:channel_n]})

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
    province = CodeTable.find(addr.province_id).name
    city = CodeTable.find(addr.city_id).name
    s = r.salesman
    s_contact = nil
    if s.contact_id
      s_contact = Contact.find(s.contact_id)
    end
    {
      'shop_name'=>r.shop_name, "contact.name"=>c.name, 'contact.tel'=>c.tel,
      'addr'=> province + ' ' + city, 'salesman'=>r.salesman.name,
      'qudao'=>'',
      'join_date'=>r.join_date, 'rate'=>r.rate
    }
  end

  def search_clients(collection, option={'search_t'=>'', 'channel_n'=>''})
    ret = []
    if option['search_t'].empty?
      return collection
    end
    q_hash = {
      'shop_name_cont'=>option['search_t'],
      'shop_tel_cont'=>option['search_t'],
      'rate_eq'=>option['search_t'].to_f,
      'id'=>option['search_t'].to_i,
      'm'=>'or'}
    collection.ransack(q_hash).result(distinct: true)
  end

end
