class ClientsController < PooulController
  def index
    page_size = $redis.get(:list_per_page) || 100
    @collection = current_user
      .agent.clients.show_order
      .page(params[:page]).per(page_size)
  end

  def show
    @object = current_user.agent.clients.find(params[:id])
    suc_code = CodeTable.find_by(name: 'trade_result').childs.where('name like ?', '交易成功').last
    @trades = @object.trades.where(:trade_result=> suc_code).show_order.page(params[:pages]).per(100)
  end

end
