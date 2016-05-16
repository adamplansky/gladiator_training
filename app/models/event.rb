class Event < ActiveRecord::Base
  mount_uploader :image, ImageUploader
  has_many :users, through: :registration
  has_many :registration

end
