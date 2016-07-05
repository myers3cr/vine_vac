FactoryGirl.define do
  factory :contact do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    message { Faker::Lorem.paragraph}
  end
end
