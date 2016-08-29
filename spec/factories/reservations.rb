FactoryGirl.define do
  factory :reservation do
    start_date Time.now
    end_date Time.now + 3.days
    association :location
    association :member
  end
end
