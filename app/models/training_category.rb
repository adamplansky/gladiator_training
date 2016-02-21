class TrainingCategory < ActiveRecord::Base
  has_many :trainings
  mount_uploader :image, ImageUploader
end
