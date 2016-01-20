require 'rails_helper'

  feature 'admin can upload csv file and add sites data' do

  sign_in_as(:admin)

  before do
    click_header_option("Dashboard")
    click_sidemenu_option("Sites")
    click_link("CSV Upload")
  end

  context 'attempting to upload no CSV or wrong file' do

    scenario 'Admin clicks import CSV with no file selected' do
      click_button("Import CSV")

      expect(current_path).to eq(admin_sites_csv_parsers_path)
      expect(page).to have_content("You must upload a CSV file")
    end

    scenario 'Admin clicks import CSV with a non csv format file' do
      attach_file('File', "spec/support/assets/fake_txt.txt")
      click_button("Import CSV")

      expect(current_path).to eq(admin_sites_csv_parsers_path)
      expect(page).to have_content("You must upload a CSV file")
    end
  end

  context 'uploading a CSV file' do

    scenario 'Admin clicks import CSV with CSV format file' do
      attach_file('File', "spec/support/assets/fake_csv.csv")
      click_button("Import CSV")

      expect(current_path).to eq(admin_sites_csv_parsers_path)
    end
  end
end





