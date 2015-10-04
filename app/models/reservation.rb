class Reservation < ActiveRecord::Base
  
  has_many :users, :through => :reservation_users
  has_many :reservation_users
  belongs_to :place
  belongs_to :user
    
  default_scope {order('time_from')}
  validates :capacity, numericality: { only_integer: true }
end
