class Salesman < ActiveRecord::Base
  has_many :clients
  belongs_to :agent
  belongs_to :client
  has_many :salesman_day_tradetotals

  scope :free_salesmen, -> { where(agent_id: nil) }
	scope :free_client_salesmen, -> { where(client_id: nil) }


  def clients_all
    @clients_all = Client.where("salesman_id"=>self.id)
    @clients_all
  end
  def trades_all
    @trades_all = Trade.where("client_id"=>self.clients_all.ids)
  end

  def new_clients
    self.clients_all.where("join_date"=>Date.current.all_month)
  end


end
