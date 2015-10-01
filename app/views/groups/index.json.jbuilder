json.array!(@groups) do |group|
  json.extract! group, :id, :name, :image_url
  json.url group_url(group, format: :json)
end
