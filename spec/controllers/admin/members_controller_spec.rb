require 'rails_helper'

RSpec.describe Admin::MembersController do

  describe 'GET index' do
    subject(:get_index) { get :index, params }
    let(:params) { {} }

    authenticated_as(:admin) do
      it { should render_template(:index) }

      describe_assign(:users) do
        subject(:users) { get_index; assigns(:users) }

        describe "filtering by role" do
          it { should include(FactoryGirl.create(:user, :member)) }
          it { should_not include(FactoryGirl.create(:user, :admin)) }
        end

        describe "filtering by email" do
          let(:params) { {search: {search_term: search_term}} }

          context "when search term is 3 or more characters" do
            let(:search_term) { "whatever" }

            it { should include(FactoryGirl.create(:user, :member, email: "whatever@example.com")) }
            it { should_not include(FactoryGirl.create(:user, :member, email: "whatnot@example.com")) }
          end

          context "when search term is fewer than 3 characters" do
            let(:search_term) { "cd" }
            it "returns an error message to the user" do
              subject
              expect(request.flash[:alert]).to include("Unable to search, requires 3 or more characters.")
            end
            it { should include(FactoryGirl.create(:user, :member, email: "ab@example.com")) }
          end
        end

        describe "sorting" do
          let(:params) { {sort_direction: direction, sort_attribute: "email"} }

          let!(:beta)  { FactoryGirl.create(:user, :member, email: "beta@example.com") }
          let!(:alpha) { FactoryGirl.create(:user, :member, email: "alpha@example.com") }

          describe "sorting by asc" do
            let(:direction) { "asc" }

            it "sorts by query parameters" do
              expect(users[0]).to eq(alpha)
              expect(users[1]).to eq(beta)
            end
          end

          describe "sorting by desc" do
            let(:direction) { "desc" }

            it "sorts by query parameters" do
              expect(users[0]).to eq(beta)
              expect(users[1]).to eq(alpha)
            end
          end
        end
      end
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
    subject(:create_user) { post :create, user: params }
    let(:params) { {} }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            email: "email@example.com",
            password: "password"
          }
        end

        it "creates a User object with the given attributes" do
          create_user

          user = User.order(:created_at).last
          expect(user).to be_present
          expect(user).to have_attributes(params.slice(:email))
          expect(user).to be_member
        end

        it { should redirect_to(admin_members_path) }
      end

      context "with invalid parameters" do
        let(:params) { {email: nil} }
        specify { expect { subject }.not_to change(User, :count) }
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'GET edit' do
    subject { get :edit, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do
      it { should be_success }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'POST update' do
    subject(:update_user) { post :update, id: target_user.id, user: params }
    let(:params) { {} }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do

      context "with valid parameters" do
        let(:params) do
          {
            email: "jordan@example.com",
            role: "member",
            password: ""
          }
        end

        it "creates a User object with the given attributes" do
          update_user

          target_user.reload
          expect(target_user.email).to eq("jordan@example.com")
        end

        it { should redirect_to(admin_members_path) }
      end

      context "with invalid parameters" do
        let(:params) do
          {
            email: "not_an_email"
          }
        end

        it "doesn't update the User" do
          update_user
          expect(target_user.reload.email).not_to eq(params[:email])
        end
      end
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

  describe 'DELETE destroy' do
    subject { delete :destroy, id: target_user.id }
    let(:target_user) { FactoryGirl.create(:user) }

    authenticated_as(:admin) do
      it "deletes the user" do
        subject
        expect(target_user.reload.deleted_at).to be_present
      end
      it { should redirect_to(admin_members_path) }
    end

    it_behaves_like "action requiring authentication"
    it_behaves_like "action authorizes roles", [:admin]
  end

end
