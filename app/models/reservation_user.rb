class ReservationUser < ActiveRecord::Base
  self.table_name = "reservations_users"
  validates_uniqueness_of :user_id, :scope => :reservation_id
  belongs_to :user
  belongs_to :reservation

  default_scope -> { order('created_at asc') }

end