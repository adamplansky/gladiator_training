class Gym < ActiveRecord::Base
    mount_uploader :image, ImageUploader
    has_many :users
    has_many :challenge_scores
    validates :name, presence: true
    validates :image, presence: true
    validates_processing_of :image
    validate :image_size_validation


    private

    def image_size_validation
      errors[:image] << "obrazek by musi mit maximalne 1MB " if image.size > 1.megabytes
    end
end
