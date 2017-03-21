FactoryGirl.define do
  factory :available_date do
    association :location
    member nil
    available_date Date.today.to_s
    status :available
    price { (100.0*rand).round(2) }
  end
end
