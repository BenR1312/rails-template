FactoryGirl.define do
  factory :company do
    name { FFaker::Company.name }
    country { FFaker::Address.country_code }
    slogan { FFaker::Company.bs }
    banner_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'banner_placeholder.png')) }
    logo { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'company_logo_placeholder.png')) }
  end
end
