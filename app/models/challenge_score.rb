class ChallengeScore < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge
  belongs_to :gym
  belongs_to :team

  validates :challenge_time, presence: {message: "Musíte uvést čast výzvy ve formátu mm:ss"}
  validates :url, presence: {message: "Musíte uvést odkaz na video"}
  validates :user_id, presence: true
  validates :challenge_id, presence: true
  validates :gym_id, presence: true
  validates :user_id, uniqueness: { scope: :challenge_id,message: "Již jste absolvoval danou výzvu." }
  validate :date_today_is_between_time_from_and_time_to


  default_scope { order('created_at DESC') }

  def challenge_time=(value)

    value = value.split(':').inject(0){|a, m| a = a * 60 + m.to_i }
    write_attribute(:challenge_time, value)
  end

  def challenge_time
    if read_attribute(:challenge_time)
      a = read_attribute(:challenge_time)
      "#{a/60}:#{(a%60).to_s.ljust(2,'0')}"
    end
  end

  def url=(value)
    write_attribute(:url, YouTubeAddy.extract_video_id(value) )
  end

  def url
    if read_attribute(:url) != nil
      return "https://www.youtube.com/watch?v=#{read_attribute(:url)}"
    end
  end

 def date_today_is_between_time_from_and_time_to
   c = Challenge.find(challenge_id)
   if c.present? && Date.today < c.from_time.to_date
     errors.add(:base,"Výzva ještě nebyla otevřena #{c.from_time.to_date}")
   elsif c.present? && Date.today > c.to_time.to_date
     errors.add(:base,"Výzva již neprobíhá #{c.to_time.to_date}")
   end
 end
end
