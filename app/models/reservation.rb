class Reservation < ActiveRecord::Base

  has_many :users, :through => :reservation_users
  has_many :reservation_users
  belongs_to :place
  belongs_to :category
  belongs_to :user

  default_scope {order('time_from')}
  validates :time_from, presence: true
  validates :time_to, presence: true
  validates :capacity, presence: true, numericality: { only_integer: true }
  validates :place_id, presence: true
  validates :category_id, presence: true
  validates :user_id, presence: true
  validates_datetime :time_from
  validates_datetime :time_to


  def week
    self.time_from.strftime('%W')
  end


end
