class Challenge < ActiveRecord::Base
  validates :url, presence: true
  validates :name, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

  belongs_to :season
  belongs_to :challenge_category

  def self.actual_challenges
    self.where("from_time <= ? AND to_time >= ?", Date.today, Date.today )
  end

end
