@future_dates = @location.available_dates.where("available_date >= ?", Date.today)
json.array!(@future_dates) do |date|
  json.start date.available_date
  json.rendering 'background'
end