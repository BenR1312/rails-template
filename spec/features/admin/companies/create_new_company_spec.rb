require 'rails_helper'

feature 'Admin can create and assign sponsors to a company', :js do

  let!(:company) { FactoryGirl.create(:company) }

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Companies")
    click_link("New Company")
  end

  context 'attempting to create a new company with no fields input' do

    scenario 'Admin clicks create a company with no fields input' do
      fill_in("Company Name", with: "")
      click_button("Create")

      expect(current_path).to eq(admin_companies_path)
      # within(".company_name") { expect(page).to have_content ("can't be blank") }
    end
  end

  context 'admin creates a company with valid fields input' do

    scenario 'admin creates a valid company' do
      # fill in company details
      fill_in 'Company Name', with: "Company Name"
      select(ISO3166::Country.new(company.country).name, from: 'Country')
      fill_in 'Slogan', with: "Company Slogan"
      attach_file("Company Banner", sample_upload_file)
      attach_file("Company Logo", sample_upload_file)
      click_link('add sponsor')
      within(".nested-fields") do
        fill_in 'Sponsor Name', with: "Sponsor Name"
        fill_in 'Description', with: "Sponsor Description"
        attach_file("Sponsor Logo", sample_upload_file)
      end
      click_button('Create')

      # Ensure user is redirected and company is created
      expect(current_path).to eq(admin_companies_path)
      latest_company = Company.order(:created_at).last
      expect(latest_company.name).to eq("Company Name")
      expect(latest_company.country).to eq(company.country)
      expect(latest_company.slogan).to eq("Company Slogan")
      expect(latest_company.banner_image).to be_present
      expect(latest_company.logo).to be_present

      latest_company = latest_company.sponsors.first
      expect(latest_company).to be_present
      expect(latest_company.name).to eq("Sponsor Name")
      expect(latest_company.description).to eq("Sponsor Description")
      expect(latest_company.logo).to be_present
    end
  end
end
