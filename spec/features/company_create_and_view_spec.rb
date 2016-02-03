require 'rails_helper'

feature 'User who is not authenticated can view Company index and profile' do

  let!(:company) { FactoryGirl.create(:company, sponsors: [sponsor]) }
  let!(:sponsor) { FactoryGirl.create(:sponsor) }

  scenario "User clicks on company name to view profile" do
    visit(root_url)
    click_link(company.name)

    expect(current_path).to eq(company_path(company))
    latest_company = Company.order(:created_at).last
    expect(latest_company.name).to eq(company.name)
    expect(latest_company.country).to eq(company.country)
    expect(latest_company.slogan).to eq(company.slogan)

    latest_sponsor = latest_company.sponsors.first
    expect(latest_sponsor).to be_present
    expect(latest_sponsor.name).to eq(sponsor.name)
    expect(latest_sponsor.description).to eq(sponsor.description) 
  end
end
