json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :time_from, :time_to, :money, :capacity
  json.url reservation_url(reservation, format: :json)
end
