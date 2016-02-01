FactoryGirl.define do
  factory :fleet_truck do
    status { ["standard", "auxiliary"].sample }
    association :fleet
    association :truck
  end

end
