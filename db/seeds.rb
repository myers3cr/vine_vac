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
  {member_id: 2, name: "Room on Conesus", description: "A Room", address_1: "123 Sesame Street", address_2: "", city: "Conesus", state: "NY", postal_code: "12345", loc_type: "Room", latitude: nil, longitude: nil, occupancy: 2, nearest_lake: "Conesus"}
])

(Date.today..(Date.today + 3.weeks)).each do |d|
  AvailableDate.create!([
    {location_id: 1, member_id: nil, available_date: d, status: 0, price_cents: 2000, price_currency: "USD"},
  ])
end
