json.array!(@dictionaries) do |dictionary|
  json.extract! dictionary, :id, :en_name, :cz_name, :abr
  json.url dictionary_url(dictionary, format: :json)
end
