class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :authentication_keys => [:mobile]

  has_many :client_notes
  belongs_to :agent

  def email_required?
    false
  end

  def admin?
    #return self.roles.include? 'admin'
    true
  end
end
