class ClientsController < ApplicationController
  def index
    page_size = $redis.get(:list_per_page) || 100
    @collection = current_user
      .agent.clients.show_order
      .page(params[:page]).per(page_size)
  end

  def show
    @object = Client.find(params[:id])
    # TODO: 防止访问不属于自己代理的商户

    @trades = @object.trades.show_order.page(params[:pages]).per(100)
  end

end
