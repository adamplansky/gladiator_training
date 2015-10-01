class User < ActiveRecord::Base
  
  has_and_belongs_to_many :reservations
  has_many :reservations, :through => :reservations_users
  has_many :reservations
  
  
#  before_create :create_activation_digest
  before_save   :downcase_email
  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i 
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },   uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  attr_accessor :remember_token, :activation_token, :reset_token
  has_secure_password
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    
  end
    
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  # Forgets a user.
   def forget
     update_attribute(:remember_digest, nil)
   end
   private

   def create_remember_token
     self.remember_token = User.digest(User.new_remember_token)
   end
   def downcase_email
     self.email = email.downcase
   end

end
