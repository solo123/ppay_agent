class ContractsController < NestedResourcesController
  before_action :edit_trade_sum_field, only: [:create, :update]

  def edit_trade_sum_field
    if params[:contract][:trade_sum]
      params[:contract][:trade_sum] = CodeTable.find_code('trade_sum', params[:contract][:trade_sum])
    end
  end

end
