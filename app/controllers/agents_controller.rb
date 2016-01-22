# coding: utf-8
class AgentsController < ResourcesController

  def show
    load_object
    agent_total = Biz::AgentTotalBiz.new params[:id]
    puts '-' * 42
    @cur_trade_total  = agent_total.trades_sum(Date.current)
    puts @cur_trade_total

    @cur_trade_total["clients_count"] = agent_total.clients_all.count
    @cur_trade_total["new_clients_count"] = agent_total.new_clients.count
    @cur_trade_total["company"] = Company.new
    puts '-' * 42
    puts @cur_trade_total

  end

  def active_clients
    load_object
    total = Biz::AgentTotalBiz.new(@object.id)
    @collection_clients = total.active_clients
  end
  def active_salesmen
    load_object
    total = Biz::AgentTotalBiz.new(@object.id)
    @collection_salesmen = total.active_salesmen
  end

  def basic_info
    show
  end

  def new_clients
    load_object
    agent_total = Biz::AgentTotalBiz.new params[:id]
    @new_clients = agent_total.new_clients

  end


end
