require 'rails_helper'

RSpec.describe Admin::TrucksController do

  describe 'GET index' do
    subject(:get_index) { get :index, params }
    let(:params) { {} }

    authenticated_as(:admin) do
      it { should render_template(:index) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET new' do
    subject { get :new } 

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST create' do
    subject(:create_truck) { post :create, truck: params }
    let(:params) { {} }

    authenticated_as(:admin) do

      let!(:truck_model) { FactoryGirl.create(:truck_model) }
      let!(:site) { FactoryGirl.create(:site) }
      let!(:driver) { FactoryGirl.create(:user) }

      context "with valid parameters" do
        let(:params) do
          {
            registration: "123456",
            truck_model_id: truck_model.id,
            driver_id: driver.id,
            site_ids: [site.id],
            scheduled_maintenance: "2016/10/01"
          }
        end

        it "creates a Truck object with the given attributes" do
          create_truck

          truck = Truck.order(:created_at).last
          expect(truck).to be_present
          expect(truck.registration).to eq(params[:registration])
          expect(truck.truck_model).to eq(truck_model)
          expect(truck.driver).to eq(driver)
          expect(truck.sites).to include(site)
          expect(truck.scheduled_maintenance.to_i).to eq(DateTime.new(2016, 10, 1).to_i)
        end
      end
    end
  end
end
