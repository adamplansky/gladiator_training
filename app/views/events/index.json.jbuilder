json.array!(@events) do |event|
  json.extract! event, :id, :title, :event_date, :registration_end, :url, :image, :description, :min_money, :contact
  json.url event_url(event, format: :json)
end
