require 'rails_helper'

RSpec.describe Admin::FleetsController do

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
    subject(:create_fleet) { post :create, fleet: params }
    let(:params) { {fleet: {id: 500}} }

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]

    authenticated_as(:admin) do
      let!(:truck) { FactoryGirl.create(:truck) }

      context "with valid parameters" do
        let(:params) do
          {
            fleet_name: "Flying Fleet",
            fleet_trucks_attributes: {
              "12345" => {
                truck_id: truck.id,
                status: "standard"
              }
            }
          }
        end

        it "creates a Fleet with the given attributes" do
          create_fleet

          fleet = Fleet.order(:created_at).last
          expect(fleet).to be_present
          expect(fleet.fleet_name).to eq(params[:fleet_name])

          fleet_truck = fleet.fleet_trucks.first
          expect(fleet_truck.truck).to eq(truck)
          expect(fleet_truck.status).to eq("standard")
        end

        it { should redirect_to admin_fleets_path }
      end

      context "with invalid parameters" do
        let(:params) { {fleet_name: nil} }
        specify { expect { subject }.not_to change(Fleet, :count) }
      end

      context "parameters create duplicate entriers for the same truck", :focus do
        let(:params) do
          {
            fleet_name: "Flying Fleet",
            fleet_trucks_attributes: {
              "12345" => {
                truck_id: truck.id,
                status: "standard"
              },
              "13345" => {
                truck_id: truck.id,
                status: "standard"
              }
            }
          }
        end

        specify { expect { subject }.not_to change(Fleet, :count) }
      end
    end
  end

  describe 'GET edit' do
    subject { get :edit, id: target_fleet.id }
    let(:target_fleet) { FactoryGirl.create(:fleet) }

    authenticated_as(:admin) do
      it { should be_success}
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do 
    subject(:update_fleet) { post :update, id: target_fleet.id, fleet: params }
    let(:params) { {fleet: {id: 300}} }
    let(:target_fleet) { FactoryGirl.create(:fleet) }

    authenticated_as(:admin) do
      let!(:truck) { FactoryGirl.create(:truck) }

      context "with valid parameters" do
        let(:params) do
          {
            fleet_name: "Flying Fleet",
            fleet_trucks_attributes: {
              "12345" => {
                truck_id: truck.id,
                status: "standard"
              }
            }
          }
        end

        it "updates a fleet with given attributes" do
          update_fleet
          target_fleet.reload
          expect(target_fleet.fleet_name).to eq("Flying Fleet")

          fleet_truck = target_fleet.fleet_trucks.first
          expect(fleet_truck.truck).to eq(truck)
          expect(fleet_truck.status).to eq("standard")

        end

        it { should redirect_to(admin_fleets_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            fleet_name: "",
            fleet_trucks_attributes: {
              "12345" => {
                truck_id: truck.id,
                status: ""
              }
            }
          }
        end

        it "doesnt update the fleet" do
          update_fleet
          expect { subject }.not_to change { target_fleet.reload.attributes }
        end
      end
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_fleet.id }
    let(:target_fleet) { FactoryGirl.create(:fleet) }

    authenticated_as(:admin) do
      it "deletes the site" do
        subject
        expect(target_fleet.delete).to be_deleted
      end
      it { should redirect_to(admin_fleets_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end
end
