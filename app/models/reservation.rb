class Reservation < ActiveRecord::Base
  
  has_many :users, :through => :reservation_users
  has_many :reservation_users
  belongs_to :place
  belongs_to :user
  

  validates :capacity, numericality: { only_integer: true }
end
