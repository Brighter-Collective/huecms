class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #associations
  has_many :contents
  has_many :comments
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :first_name, :last_name, :middle_name, :username, :role

  ROLES = %w[admin moderator author]

  #validations
  validates_inclusion_of :role, in: ROLES, allow_nil: true

  #methods
  def admin?
    self.role == 'admin'
  end
  
  def display_name
    username || email
  end
    
end
