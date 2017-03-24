Member.create!([
  {email: "user@example.com", encrypted_password: "$2a$10$0lwdUA.9PhBo/p/nRvjexuxJmSUFimS2Bi1Rg4x5Hu1brRKLRHlKC", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2017-03-01 21:06:52", last_sign_in_at: "2017-03-01 21:06:52", current_sign_in_ip: "::1", last_sign_in_ip: "::1"},
  {email: "jsr@gmail.com", encrypted_password: "$2a$10$87gX2LOOXVrek8PeDnNrZO50lIEVtSXB8pV2m7b89vFBYbYLBm6Pi", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 4, current_sign_in_at: "2017-03-14 21:29:17", last_sign_in_at: "2017-03-03 16:02:11", current_sign_in_ip: "::1", last_sign_in_ip: "::1"},
  {email: "crm@gmail.com", encrypted_password: "$2a$10$7QwrxVKBXNZg3/qnAKnNgeaA9.JK6OkrSxJlHum5Vf6AccxAVyv6O", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 11, current_sign_in_at: "2017-03-23 14:59:44", last_sign_in_at: "2017-03-12 17:43:07", current_sign_in_ip: "::1", last_sign_in_ip: "::1"}
])
AvailableDate.create!([
  {location_id: 2, member_id: nil, available_date: "2017-03-15", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-16", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-17", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-18", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-19", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-20", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-21", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-22", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-23", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-24", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-13", status: 0, price_cents: 2000, price_currency: "USD"},
  {location_id: 2, member_id: nil, available_date: "2017-03-14", status: 0, price_cents: 2000, price_currency: "USD"}
])
Location.create!([
  {member_id: 2, name: "Room on Conesus", description: "A Room", address_1: "123 Sesame Street", address_2: "", city: "Conesus", state: "NY", postal_code: "12345", loc_type: "Room", latitude: nil, longitude: nil, occupancy: 2, nearest_lake: "Conesus"}
])
Profile.create!([
  {member_id: 1, profile_type: nil, first_name: "C.R.", last_name: "Myers", address_1: "3 Shadow Vale Dr", address_2: "", city: "Penfield", state: "NY", postal_code: "14526", profile_pic_file_name: "Vlad_the_Impaler.jpg", profile_pic_content_type: "image/jpeg", profile_pic_file_size: 72428, profile_pic_updated_at: "2017-03-01 19:36:27"},
  {member_id: 2, profile_type: nil, first_name: "Joanne", last_name: "Redmore", address_1: "3 Shadow Vale Dr", address_2: "", city: "Penfield", state: "NY", postal_code: "14526", profile_pic_file_name: nil, profile_pic_content_type: nil, profile_pic_file_size: nil, profile_pic_updated_at: nil},
  {member_id: 3, profile_type: nil, first_name: "Richard", last_name: "Feynman", address_1: "123 Sesame Street", address_2: "", city: "Anytown", state: "NY", postal_code: "12345", profile_pic_file_name: "Feynman_2553738b.jpg", profile_pic_content_type: "image/jpeg", profile_pic_file_size: 52907, profile_pic_updated_at: "2017-03-01 21:08:01"}
])
