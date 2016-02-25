class TradesController < PooulController
  def load_collection
    suc_code = CodeTable.find_by(name: 'trade_result').childs.where('name like ?', '交易成功').last
    @q = Trade.where(:client=> current_user.agent.clients, :trade_result=> suc_code).show_order.ransack( params[:q] )
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
