json.array!(@places) do |place|
  json.extract! place, :id, :name, :map_url
  json.url place_url(place, format: :json)
end
