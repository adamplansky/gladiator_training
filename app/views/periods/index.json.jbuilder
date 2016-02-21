json.array!(@periods) do |period|
  json.extract! period, :id, :from, :to, :name
  json.url period_url(period, format: :json)
end
