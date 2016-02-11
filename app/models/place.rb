class Place < ActiveRecord::Base
  has_many :reservations
  validates :name, presence: true
  validates :map_url, presence: true
end
