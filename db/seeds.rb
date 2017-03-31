AvailableDate.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('available_dates')

Location.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('locations')

Profile.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('profiles')

Member.destroy_all
ActiveRecord::Base.connection.reset_pk_sequence!('members')

Member.create!([
  {email: "crm@gmail.com", password: "purecane", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 11, current_sign_in_at: "2017-03-23 14:59:44", last_sign_in_at: "2017-03-12 17:43:07", current_sign_in_ip: "::1", last_sign_in_ip: "::1"},
  {email: "jsr@gmail.com", password: "purecane", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2017-03-14 21:29:17", last_sign_in_at: "2017-03-03 16:02:11", current_sign_in_ip: "::1", last_sign_in_ip: "::1"},
  {email: "user@example.com", password: "purecane", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-03-01 21:06:52", last_sign_in_at: "2017-03-01 21:06:52", current_sign_in_ip: "::1", last_sign_in_ip: "::1"}
])

Profile.create!([
  {member_id: 1, profile_type: nil, first_name: "C.R.", last_name: "Myers", address_1: "3 Shadow Vale Dr", address_2: "", city: "Penfield", state: "NY", postal_code: "14526", profile_pic_file_name: nil, profile_pic_content_type: nil, profile_pic_file_size: nil, profile_pic_updated_at: nil},
  {member_id: 2, profile_type: nil, first_name: "Joanne", last_name: "Redmore", address_1: "3 Shadow Vale Dr", address_2: "", city: "Penfield", state: "NY", postal_code: "14526", profile_pic_file_name: nil, profile_pic_content_type: nil, profile_pic_file_size: nil, profile_pic_updated_at: nil},
  {member_id: 3, profile_type: nil, first_name: "Richard", last_name: "Feynman", address_1: "123 Sesame Street", address_2: "", city: "Anytown", state: "NY", postal_code: "12345", profile_pic_file_name: nil, profile_pic_content_type: nil, profile_pic_file_size: nil, profile_pic_updated_at: nil}
])

Location.create!([
  {member_id: 1, name: "Room on Conesus", description: "A Room", address_1: "5564 E Lake Rd", address_2: "", city: "Conesus", state: "NY", postal_code: "14435", loc_type: "Room", latitude: nil, longitude: nil, occupancy: 2, nearest_lake: "Conesus"},
  {member_id: 1, name: "House on Seneca", description: "4 BR House", address_1: "200 Seneca Street", address_2: "", city: "Dresden", state: "NY", postal_code: "14441", loc_type: "House", latitude: nil, longitude: nil, occupancy: 8, nearest_lake: "Seneca"},
  {member_id: 1, name: "Apartment on Canandaigua", description: "1 BR Apartment", address_1: "28 Lakeshore Dr", address_2: "Apt. 2B", city: "Canandaigua", state: "NY", postal_code: "14424", loc_type: "House", latitude: nil, longitude: nil, occupancy: 8, nearest_lake: "Seneca"},
  {member_id: 2, name: "Room on Canandaigua", description: "A Room", address_1: "4478 Lake Dr", address_2: "", city: "Canandaigua", state: "NY", postal_code: "14424", loc_type: "Room", latitude: nil, longitude: nil, occupancy: 2, nearest_lake: "Canandaigua"},
  {member_id: 2, name: "Apartment on Skaneateles", description: "2 BR apartment", address_1: "3 Leitch Avenue", address_2: "", city: "Skaneateles", state: "NY", postal_code: "13152", loc_type: "Apartment", latitude: nil, longitude: nil, occupancy: 4, nearest_lake: "Skaneateles"},
  {member_id: 3, name: "House on Cayuga", description: "High above Cayuga's waters", address_1: "123 Utica Street", address_2: "", city: "Ithaca", state: "NY", postal_code: "14852", loc_type: "House", latitude: nil, longitude: nil, occupancy: 8, nearest_lake: "Cayuga"}
])

(Date.today..(Date.today + 3.weeks)).each do |d|
  AvailableDate.create!([
    {location_id: 1, member_id: nil, available_date: d, status: 0, price_cents: 2000, price_currency: "USD"},
  ])
end

(Date.new(2017,6,1).all_month()).each do |d|
  AvailableDate.create!([
    {location_id: 2, member_id: nil, available_date: d, status: 0, price_cents: 6000, price_currency: "USD"},
  ])
end
(Date.new(2017,7,4).all_week()).each do |d|
  AvailableDate.create!([
    {location_id: 2, member_id: nil, available_date: d, status: 0, price_cents: 10000, price_currency: "USD"},
  ])
end

(Date.new(2017,7,4).all_week()).each do |d|
  AvailableDate.create!([
    {location_id: 3, member_id: nil, available_date: d, status: 0, price_cents: 6000, price_currency: "USD"},
  ])
end

(Date.new(2017,8,1)..Date.new(2017,8,14)).each do |d|
  AvailableDate.create!([
    {location_id: 4, member_id: nil, available_date: d, status: 0, price_cents: 5000, price_currency: "USD"},
  ])
end

(Date.new(2017,8,1).all_month()).each do |d|
  AvailableDate.create!([
    {location_id: 5, member_id: nil, available_date: d, status: 0, price_cents: 8000, price_currency: "USD"},
  ])
end
