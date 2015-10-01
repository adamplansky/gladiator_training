json.array!(@workouts) do |workout|
  json.extract! workout, :id, :name, :description
  json.url workout_url(workout, format: :json)
end
