FactoryGirl.define do
  factory :sponsor do
    name { FFaker::Company.name }
    logo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'sponsor_logo_placeholder.png')) }
    description { FFaker::Company.bs }
    association :company
  end
end
