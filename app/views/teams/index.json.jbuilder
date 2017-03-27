json.array!(@teams) do |team|
  json.extract! team, :id, :name, :logo_url
  json.url team_url(team, format: :json)
end
