json.array!(@gym_wars) do |gym_war|
  json.extract! gym_war, :id, :description
  json.url gym_war_url(gym_war, format: :json)
end
