require 'rails_helper'

feature 'Admin can delete an existing Fleet' do

  signed_in_as(:admin) do
    let!(:target_fleet) { FactoryGirl.create(:fleet, fleet_name: "fleety") }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Fleets")
    end

    scenario 'Admin can delete Fleet' do
      within_row(target_fleet.fleet_name) do
        click_link("Delete")
      end
      
      expect(target_fleet.reload).to be_deleted
      expect(page).to have_flash(:notice, "Fleet was successfully deleted.")
    end
  end
end
