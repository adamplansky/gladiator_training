json.array!(@gyms) do |gym|
  json.extract! gym, :id, :name, :image
  json.url gym_url(gym, format: :json)
end
