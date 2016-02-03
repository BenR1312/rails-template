require 'rails_helper'

feature 'Admin can create and assign sponsors to a company' do

  let!(:company) { FactoryGirl.create(:company) }

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Companies")
  end

  scenario "showing companies" do
    expect(page).to have_content(company.name)
  end
end
