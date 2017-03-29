class Challenge < ActiveRecord::Base
  validates :url, presence: true
  validates :name, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

  belongs_to :season
  belongs_to :challenge_category

  # def from_time
  #   if read_attribute(:from_time)
  #     read_attribute(:from_time).strftime("%d.%m.%Y")
  #   end
  # end
  #
  # def to_time
  #   if read_attribute(:to_time)
  #     read_attribute(:to_time).strftime("%d.%m.%Y")
  #   end
  # end


end
