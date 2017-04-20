module LeaderboardsHelper
  def get_challenge_time(number)
    number = number.to_i
    "#{number/60}:#{(number%60).to_s.rjust(2,'0')}"
  end
end
