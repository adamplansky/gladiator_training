json.array!(@training_categories) do |training_category|
  json.extract! training_category, :id, :name, :koef, :minimum, :description, :units
  json.url training_category_url(training_category, format: :json)
end
