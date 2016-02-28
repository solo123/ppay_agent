class ClientsController < PooulController
  def index
    page_size = $redis.get(:list_per_page) || 100
    @collection = current_user
      .agent.clients.show_order
      .page(params[:page]).per(page_size)
  end

  def show
    @object = current_user.agent.clients.find(params[:id])
    @trades = @object.trades.show_order.page(params[:pages]).per(100)
  end

end
