class AgentsController < ApplicationController

  def current
    @object = current_user.agent
    render :show
  end
  # def show
  #   # @object = current_user.agent
  #   #
  #   # @month_total = agent_sum_month @object, Date.current.to_s[0..6], 'all', 'amount'
  #   # @all_total = TradeSum.where(sum_obj: @object, sum_type: 'month', trade_type: 'all').sum("amount")
  #   # @last_amount = agent_sum_month @object, Date.current.last_month.to_s[0..6], 'all', 'amount'
  #
  # end

  def active_clients
    @collection_clients = @agent_total.active_clients
  end
  def active_salesmen
    @collection_salesmen = @agent_total.active_salesmen
  end
  def basic_info
    @object = current_user.agent

  end
  def new_clients
    @new_clients = @agent_total.new_clients
  end

end
