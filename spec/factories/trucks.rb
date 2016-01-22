FactoryGirl.define do
  factory :truck do
    registration "MyString"
    association :truck_model
    association :driver, factory: :user
    scheduled_maintenance "2016-01-21 12:32:48"
  end

end
