class AgentsController < ApplicationController

  def current
    @object = current_user.agent
    render :show
  end
  def basic_info
    @object = current_user.agent
  end
  def new_clients
    @new_clients = current_user.agent.clients.order('join_date desc').take(10)
  end

end
