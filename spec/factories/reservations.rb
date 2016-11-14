FactoryGirl.define do
  factory :reservation do
    start_date Time.now
    end_date Time.now + 3.days
    occupancy 1
    association :location
    association :member

    factory :available_reservation do
      after(:build) { |res| create_availabilities(res.start_date, res.end_date) }
    end

    factory :unavailable_reservation do
    end
    
  end
end

def create_availabilities(start_date, end_date)
  (start_date..end_date).each do |d|
    a = FactoryGirl.build(:available_date)
    a.available_date = d
    a.save
  end
end
