class Season < ActiveRecord::Base
  has_many :challenges

  def self.current_season
    Season.where("from_time < ? AND to_time > ?", DateTime.now, DateTime.now).first
  end

end
