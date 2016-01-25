FactoryGirl.define do
  factory :truck do
    registration { FFaker::Name.name }
    association :truck_model
    association :driver, factory: :user
    scheduled_maintenance { 10.days.from_now }
  end

end
