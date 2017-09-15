  json.array!(@reservations) do |reservation|
    json.title reservation.location.name
    json.start reservation.start_date
    json.end reservation.end_date
    json.color 'lightgreen'
    json.textColor 'black'
  end