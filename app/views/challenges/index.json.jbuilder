json.array!(@challenges) do |challenge|
  json.extract! challenge, :id, :url, :name, :description
  json.url challenge_url(challenge, format: :json)
end
