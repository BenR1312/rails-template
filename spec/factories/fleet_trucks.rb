FactoryGirl.define do
  factory :fleet_truck do
    status "MyString"
    association :fleet
    association :truck
  end

end
