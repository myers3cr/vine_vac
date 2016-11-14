FactoryGirl.define do
  factory :location do
    loc_type { Location::LOC_TYPES.sample }
    name { Faker::Hipster.words(3).join(' ') }
    description { Faker::Lorem.paragraph }
    occupancy { rand(1..20)}
    address_1 { "1 Park Ave" }
    address_2 { Faker::Address.secondary_address }
    city { "New York" }
    state { "NY" }
    postal_code { Faker::Address.zip }
    association :member
  end
end
