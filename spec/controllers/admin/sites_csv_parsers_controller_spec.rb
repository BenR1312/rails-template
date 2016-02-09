require 'rails_helper'

RSpec.describe Admin::SitesCsvParsersController do

  describe 'GET new' do
    subject { get :new }

    authenticated_as(:admin) do
      it { should render_template(:new) }
    end
  end

  describe 'POST create' do
    subject(:upload_file) { post :create, file: file } 

    authenticated_as(:admin) do
      context "a CSV file is uploaded" do
        let(:file) { Rack::Test::UploadedFile.new("spec/support/assets/fake_csv.csv", 'text/csv') }

        # it "parses the CSV" do
        #   stub_parser = double
        #   expect(SitesCsvParser).to receive(:new).with(file).and_return(stub_parser)

        #   upload_file

        #   expect(assigns(:csv_parser)).to eq(stub_parser)
        # end
      end

      context "a file that is not a CSV is uploaded" do
        let(:file) { Rack::Test::UploadedFile.new("spec/support/assets/fake_txt.txt") }
        it { should render_template(:new) }
        it "renders an error message to the user" do
          upload_file
          expect(flash[:alert]).to be_present
        end
      end

      context "no file is uploaded" do
        let(:file) { nil }
        it { should render_template(:new) }
        it "renders an error message to the user" do
          upload_file
          expect(flash[:alert]).to be_present
        end
      end
    end
  end
end
