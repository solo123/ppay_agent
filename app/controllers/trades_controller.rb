class TradesController < ResourcesController
  def load_collection
		params[:q] ||= {}
    @q = Trade.where(:client=> current_user.agent.clients).show_order.ransack(params[:q])
		pages = $redis.get(:list_per_page) || 100
		@all_data = @q.result
		@collection = @q.result
      .page(params[:page])
      .per(pages)
      .includes(:client)
	end

  def client_trades
    @collection = Trade.where(client_id: params[:client_id]).limit(10)
  end
end
