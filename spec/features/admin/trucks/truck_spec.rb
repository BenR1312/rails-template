require 'rails_helper'

feature 'admin can create and assign members to trucks' do

  let!(:truck) { FactoryGirl.create(:truck, truck_model: truck_model) }
  let!(:truck_model) { FactoryGirl.create(:truck_model) }
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

    scenario 'admin creates a valid truck', :focus do
      
      fill_in 'Registration', with: "rego123"
      fill_in 'truck_scheduled_maintenance', with: "01/09/2016"
      select(truck_model.name, from: 'Truck model')
      select(truck.driver, from: 'Driver')
      check("truck_site_ids_1")
      click_button("Create")
      expect(current_path).to eq(admin_trucks_path)
    end
  end
end
