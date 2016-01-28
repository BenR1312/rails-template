require 'rails_helper'

# TODO: Change file name
feature 'Admin can create and assign members to trucks' do

  let!(:driver) { FactoryGirl.create(:user) }
  let!(:truck_model) { FactoryGirl.create(:truck_model) }
  let!(:site) { FactoryGirl.create(:site) }

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Trucks")
    click_link("New Truck")
  end

  context 'attempting to create a user with no fields input' do

    scenario 'Admin clicks create with no data input in fields' do
      click_button("Create")

      expect(current_path).to eq(admin_trucks_path)
    end
  end

  context 'admin creates a truck with valid fields input' do

    scenario 'admin creates a valid truck' do
      # Fill in Truck details
      fill_in 'Registration', with: "rego123"
      fill_in 'truck_scheduled_maintenance', with: "01/09/2016"
      select(truck_model.name, from: 'Truck model')
      select(driver.email, from: 'Driver')
      check(site.name)
      click_button("Create")

      # Ensure that user is redirected and Truck is created
      expect(current_path).to eq(admin_trucks_path)
      latest_truck = Truck.order(:created_at).last
      expect(latest_truck.registration).to eq("rego123")
      expect(latest_truck.scheduled_maintenance).to eq("01/09/2016")
      expect(latest_truck.truck_model.name).to eq(truck_model.name)
      expect(latest_truck.driver).to eq(driver)
      page.has_content?('rego123')

    end
  end
end
