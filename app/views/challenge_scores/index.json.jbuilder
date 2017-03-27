json.array!(@challenge_scores) do |challenge_score|
  json.extract! challenge_score, :id, :challenge_time, :url, :user_id, :challenge_id
  json.url challenge_score_url(challenge_score, format: :json)
end
