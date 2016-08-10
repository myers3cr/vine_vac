FactoryGirl.define do
  factory :picture do
    location_id nil
    caption { Faker::Hipster.words(3).join(' ') }
    image ""
  end
end
