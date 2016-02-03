class AgentsController < ApplicationController
  before_action :load_object

  def show
    @month_total = ClientDayTradetotal.where(:client_id=> @agent_total.clients_all.ids,
          :trade_date=> DateTime.now.all_month)

    @all_total  = {:client_count=> @agent_total.clients_all.count,
      :new_client_count=> @agent_total.clients_all.where(:join_date=>  DateTime.now.all_month).count}
    @last_amount = ClientDayTradetotal.where(:client_id=> @agent_total.clients_all.ids,
          :trade_date=> DateTime.now.last_month.all_month).sum("total_amount")

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
