json.array!(@trainings) do |training|
  json.extract! training, :id, :training_category_id, :points, :description, :distance
  json.url training_url(training, format: :json)
end
