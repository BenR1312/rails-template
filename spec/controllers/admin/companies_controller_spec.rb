require 'rails_helper'

RSpec.describe Admin::CompaniesController do

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

  describe 'POST create', :focus do
    subject(:create_company) { post :create, company: params }
    let(:params) { {company: {id: 300}} }

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            name: "Name",
            country: "Australia",
            slogan: "Slogan",
            banner_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'banner_placeholder.png')),
            logo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'company_logo_placeholder.png')),
            sponsors_attributes: {
              "112233" => {
                name: "Sponsor Name",
                description: "Sponsor Description",
                logo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'sponsor_logo_placeholder.png')),
              }
            }
          }
        end

        it "creates a Company with the given attributes" do
          create_company

          company = Company.order(:created_at).last
          expect(company).to be_present
          expect(company.banner_image).to be_present
          expect(company.logo).to be_present
          expect(company.name).to eq(params[:name])
          expect(company.country).to eq(params[:country])
          expect(company.slogan).to eq(params[:slogan])

          sponsor = company.sponsors.first
          expect(sponsor.name).to eq("Sponsor Name")
          expect(sponsor.description).to eq("Sponsor Description")
          expect(sponsor.logo).to be_present
        end

        it { should redirect_to admin_companies_path }
      end

      context "with invalid parameters" do
        let(:params) { {name: nil} }
        specify { expect { subject }.not_to change(Company, :count) }
      end
    end
  end

  describe 'GET edit' do
    subject {get :edit, id: target_company.id }
    let(:target_company) { FactoryGirl.create(:company) }

    authenticated_as(:admin) do
      it { should be_success }
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject(:update_company) { post :update, id: target_company.id, company: params }
    let(:params) { {fleet: {id: 400}} }
    let(:target_company) { FactoryGirl.create(:company) }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            name: "Company Name",
            country: "Australia",
            slogan: "Company Slogan",
            banner_image: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'banner_placeholder.png')),
            logo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'company_logo_placeholder.png')),
            sponsors_attributes: {
              "112233" => {
                name: "Sponsor Name",
                description: "Sponsor Description",
                logo: Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'company', 'sponsor_logo_placeholder.png')),
              }
            }
          }
        end

        it "updates a company with given attributes" do
          update_company
          target_company.reload
          expect(target_company.name).to eq("Company Name")
          expect(target_company.country).to eq("Australia")
          expect(target_company.slogan).to eq("Company Slogan")

          sponsor = target_company.sponsors.first
          expect(sponsor.name).to eq("Sponsor Name")
          expect(sponsor.description).to eq("Sponsor Description")
        end

        it { should redirect_to(admin_companies_path) }
      end

      context "attempt to update comapny with invalid parameters" do
        let(:params) do
          {
            name: "",
            country: "Australia",
            slogan: "Company Slogan",
            sponsors_attributes: {
              "112233" => {
                name: "Sponsor Name",
                description: ""
              }
            }
          }
        end

        it "doesnt update the company" do
          update_company
          expect { subject }.not_to change { target_company.reload.attributes }
        end
      end
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_company.id }
    let(:target_company) { FactoryGirl.create(:company) }

    authenticated_as(:admin) do
      it "deletes the company" do
        subject
        expect(target_company.reload).to be_deleted
      end
      
      it { should redirect_to(admin_companies_path) }
    end
    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end
end
