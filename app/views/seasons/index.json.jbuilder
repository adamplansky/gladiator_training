json.array!(@seasons) do |season|
  json.extract! season, :id, :from_time, :to_time, :name
  json.url season_url(season, format: :json)
end
