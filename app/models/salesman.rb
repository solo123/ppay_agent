class Salesman < ActiveRecord::Base
  has_many :clients
  belongs_to :salesman
  belongs_to :agent
  has_many :salesman_day_tradetotals

  scope :free_salesmen, -> { where(agent_id: nil) }
	scope :free_client_salesmen, -> { where(client_id: nil) }


  def agent_info
    if self.agent==nil
      Agent.where('id=1').last
    else
      self.agent
    end
  end
  def contact_info
    # if self.contact==nil
    #   Contact.where("id=2").last
    # else
    #   self.contact
    # end
    nil
  end
end
