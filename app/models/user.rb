class User < ActiveRecord::Base

#  has_and_belongs_to_many :reservations
  has_many :reservations, :through => :reservations_users
  has_many :reservations
  has_many :trainings
  has_many :events, through: :registration
  belongs_to :gym


#  before_create :create_activation_digest
  before_save { self.email = email.downcase }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :surname, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },   uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :gender, presence: true
  attr_accessor :remember_token, :activation_token, :reset_token
  has_secure_password

  attr_accessor :updating_password


  def fullname
    "#{self.first_name} #{self.surname}##{id}"
  end

  def my_points
    Training.where(user: self).map(&:points).reduce(:+).try(:round,2)
  end

  def my_rank
    sums = Training.unscope(:order).joins(:user).group("user_id").order("sum_points DESC").sum(:points)
    return '---' unless sums.keys.index(self.id)
    sums.keys.index(self.id)+1
  end

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
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  # Sends password reset email
  def send_password_reset_email
    Notifier.password_reset(self).deliver_now
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
