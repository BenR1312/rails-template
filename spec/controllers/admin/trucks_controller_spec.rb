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
    # Put some irrelevant data in here to satisfy params.require(:truck)
    let(:params) { {truck: {id: 666}} }

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]

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

  describe 'GET edit' do
    subject { get :edit, id: target_truck.id }
    let(:target_truck) { FactoryGirl.create(:truck) }

    authenticated_as(:admin) do
      it { should be_success}
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject(:update_truck) { post :update, id: target_truck.id, truck: params }
    # Put some irrelevant data in here to satisfy params.require(:truck)
    let(:params) { {truck: {id: 666}} }
    let(:target_truck) { FactoryGirl.create(:truck) }

    authenticated_as(:admin) do

      let!(:truck_model) { FactoryGirl.create(:truck_model) }
      let!(:site) { FactoryGirl.create(:site) }
      let!(:driver) { FactoryGirl.create(:user) }

      context "with valid parameters" do
        let(:params) do 
          {
            registration: "123334456",
            truck_model_id: truck_model.id,
            driver_id: driver.id,
            site_ids: [site.id],
            scheduled_maintenance: "2016/10/01"
          }
        end

        it "creates a Truck object with the given attributes" do
          update_truck

          target_truck.reload
        end

        it { should redirect_to(admin_trucks_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            registration: " ",
            truck_model_id: truck_model.id,
            driver_id: driver.id,
            site_ids: [site.id],
            scheduled_maintenance: " "
          }
        end

        it "doesnt update the truck" do
          update_truck
          expect(target_truck.reload).not_to eq(truck: params)
        end
      end
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end


  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_truck.id }
    let(:target_truck) { FactoryGirl.create(:truck) }

    authenticated_as(:admin) do
      it "deletes the site" do
        subject
        expect(target_truck.delete)
      end
      it { should redirect_to(admin_trucks_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end
end
