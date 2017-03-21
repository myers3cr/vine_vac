FactoryGirl.define do
  factory :reservation do
    start_date Date.today.to_s
    end_date (Date.today + 1.day).to_s
    occupancy 1
    association :location
    association :member

    factory :available_reservation do
      after(:build) { |res| create_availabilities(res.location, res.start_date, res.end_date) }
    end

    factory :unavailable_reservation do
    end

  end
end

def create_availabilities(location, start_date, end_date)
  (start_date..end_date).each do |d|
    a = FactoryGirl.build(:available_date)
    a.location = location
    a.available_date = d
    a.save
  end
end
