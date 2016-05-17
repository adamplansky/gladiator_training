class Event < ActiveRecord::Base

  mount_uploader :image, ImageUploader
  has_many :users, through: :registration
  has_many :registration
  validates :title, presence: true
  validates :url, presence: true
  validates :place, presence: true
  validates :place_url, presence: true
  validates :image, presence: true

  validates_processing_of :image
  validate :image_size_validation

  default_scope -> { order('event_date asc') }

  private

    def image_size_validation
      errors[:image] << "obrazek by mel mit maximalne 1MB " if image.size > 1.megabytes
    end

end
