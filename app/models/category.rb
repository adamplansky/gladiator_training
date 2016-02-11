class Category < ActiveRecord::Base
  has_many :reservations
  validates :name, presence: true
end
