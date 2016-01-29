require 'rails_helper'

feature 'Admin can create and assign trucks to a fleet', :js do

  let!(:truck) { FactoryGirl.create(:truck) }

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Fleets")
    click_link("New Fleet")
  end

  context 'attempting to create a new fleet with no fields input' do

    scenario 'Admin clicks create a fleet with no fields input' do
      fill_in("Fleet name", with: "")
      click_button("Create")

      # TODO: Assert flash message is present
      expect(current_path).to eq(admin_fleets_path)
      within(".fleet_fleet_name") { expect(page).to have_content ("can't be blank") }
    end
  end

  context 'admin creates a fleet with valid fields input' do

    scenario 'admin creates a valid fleet' do
      # fill in fleet details
      fill_in 'fleet_fleet_name', with: "fleetyfleet"
      click_link('add a truck')
      select(truck.registration, from: 'Truck')
      choose('Auxiliary')
      click_button('Create')

      # Ensure user is redirected and fleet is created
      expect(current_path).to eq(admin_fleets_path)
      latest_fleet = Fleet.order(:created_at).last
      expect(latest_fleet.fleet_name).to eq("fleetyfleet")

      fleet_truck = latest_fleet.fleet_trucks.first
      expect(fleet_truck).to be_present
      expect(fleet_truck.truck).to eq(truck)
      expect(fleet_truck.status).to eq("auxiliary")
    end
  end

  # TODO: Can remove existing FleetTruck - move this to update spec
end
