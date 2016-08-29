FactoryGirl.define do
  factory :location do
    loc_type { Location::LOC_TYPES.sample }
    name { Faker::Hipster.words(3).join(' ') }
    description { Faker::Lorem.paragraph }
    address_1 { Faker::Address.street_address }
    address_2 { Faker::Address.secondary_address }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postal_code { Faker::Address.zip }
    association :member
  end
end
