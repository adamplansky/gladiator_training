class Challenge < ActiveRecord::Base
  #require 'youtube_addy'
  validates :name, presence: true
  validates :from_time, presence: true
  validates :to_time, presence: true

  belongs_to :season
  belongs_to :challenge_category

  def self.actual_challenges
    self.where("from_time <= ? AND to_time >= ?", Date.today, Date.today )
  end

  def url=(value)
    write_attribute(:url, YouTubeAddy.extract_video_id(value) )
  end

end
