# coding: utf-8
class AgentsController < ResourcesController
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


end
