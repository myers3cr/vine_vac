FactoryGirl.define do
  factory :profile do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address_1 { FFaker::AddressUS.street_address }
    address_2 { FFaker::AddressUS.secondary_address }
    city { FFaker::AddressUS.city }
    state { FFaker::AddressUS.state_abbr }
    postal_code { FFaker::AddressUS.zip_code }
  end
end
