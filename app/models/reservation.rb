class Reservation < ActiveRecord::Base
  
  has_many :users, :through => :reservation_users
  has_many :reservation_users
end
