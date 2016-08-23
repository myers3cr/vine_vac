json.array!(@reservations) do |reservation|
  json.extract! reservation, :id, :start_date, :end_date, :location_id, :member_id
  json.url reservation_url(reservation, format: :json)
end
