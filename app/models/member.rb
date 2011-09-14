class Member < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :status
  
  after_initialize :init
  
  STATUS = ["pending", "active", "expired", "banned"]
  
  def init
    self.status ||= 'pending'
  end

  def status_enum
    STATUS
  end
  
  def is?(status)
    STATUS.include?(status)
  end
end
