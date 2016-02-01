require 'rails_helper'

feature 'Admin can update an existing fleet' do

  signed_in_as(:admin) do
    let!(:target_fleet) { FactoryGirl.create(:fleet, fleet_name: "fleetlord") }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Fleets")
      within_row(target_fleet.fleet_name) do
        click_link("Edit")
      end
    end

    scenario 'Admin updates fleet with valid data' do
      fill_in("Fleet name", with: "fleety")
      click_button("Save Changes")

      # Current fleet should be redirected to the index
      expect(current_path).to eq(admin_fleets_path)

      # fleet should be saved
      latest_fleet = Fleet.order(:created_at).last
      expect(latest_fleet.fleet_name).to eq("fleety")
    end

    scenario 'Admin updates fleet with invalid data' do
      fill_in("Fleet name", with: "")
      click_button("Save Changes")

      # Ensure fleet is not updated
      expect(target_fleet.reload.fleet_name).to eq("fleetlord")
      within(".fleet_fleet_name") { expect(page).to have_content ("can't be blank") }
    end
  end
end
