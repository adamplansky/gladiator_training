class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :users, through: :registration
  has_many :registration
  validates :title, presence: true
  validates :url, presence: true
  validates :place, presence: true
  validates :place_url, presence: true
  validates :image, presence: true
end
