class AgentsController < ApplicationController
  before_action :load_object

  def show
    @cur_trade_total  = @agent_total.trades_sum(Date.current)
    @cur_trade_total["clients_count"] = @agent_total.clients_all.count
    @cur_trade_total["new_clients_count"] = @agent_total.new_clients.count
    @cur_trade_total["company"] = Company.new
  end
  def active_clients
    @collection_clients = @agent_total.active_clients
  end
  def active_salesmen
    @collection_salesmen = @agent_total.active_salesmen
  end
  def basic_info
    show
  end
  def new_clients
    @new_clients = @agent_total.new_clients
  end

  private
    def load_object
      @object = current_user.agent
      @agent_total = Biz::AgentTotalBiz.new(@object.id)
    end
end
