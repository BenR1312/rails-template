require 'rails_helper'

feature 'Admin can view an index of fleets' do

  signed_in_as(:admin) do
    let!(:fleet) { FactoryGirl.create(:fleet) }

    before do
      click_header_option("Dashboard")
      click_sidemenu_option("Fleets")
    end

    scenario "Showing fleets" do 
      expect(page).to have_content(fleet.fleet_name)
    end

    scenario 'Admin can delete Fleet' do
      within_row(fleet.fleet_name) do
        click_link("Delete")
      end

      expect(fleet.reload).to be_deleted
    end
  end
end
