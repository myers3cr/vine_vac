FactoryGirl.define do
  factory :reservation do
    start_date Time.now
    end_date Time.now + 3.days
    location
    member
  end
end
