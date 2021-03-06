require 'rails_helper'

RSpec.describe UserPolicy do
  subject { policy }
  let(:policy) { UserPolicy.new(user, target_user) }
  let(:target_user) { user }

  context "for an anonymous user" do
    let(:user) { nil }

    it_behaves_like "Policy without access to CRUD actions"
    it { should_not permit_access_to(:index_admins) }
  end

  context "for an admin" do
    let(:user) { FactoryGirl.build(:user, :admin) }

    # CRUD actions
    it { should permit_access_to(:index) }
    it { should permit_access_to(:new) }
    it { should permit_access_to(:create) }
    it { should permit_access_to(:edit) }
    it { should permit_access_to(:update) }
    it { should permit_access_to(:index_admins) }

    context "when the user in question is the admin" do
      let(:target_user) { user }
      it { should_not permit_access_to(:destroy) }
    end

    context "when the user in question is another admin" do
      let(:target_user) { FactoryGirl.create(:user, :admin) }
      it { should permit_access_to(:destroy) }
    end
  end

  context "for a member" do
    let(:user) { FactoryGirl.build(:user, :member) }

    # CRUD actions
    it { should_not permit_access_to(:index) }
    it { should_not permit_access_to(:index_admins) }
    it { should_not permit_access_to(:new) }
    it { should_not permit_access_to(:create) }
    describe "update?" do
      context "when user is current user" do
        let(:target_user) { user }
        it { should permit_access_to(:edit) }
        it { should permit_access_to(:update) }
      end
      context "when user is other user" do
        let(:target_user) { FactoryGirl.build(:user) }
        it { should_not permit_access_to(:edit) }
        it { should_not permit_access_to(:update) }
      end
    end
    it { should_not permit_access_to(:destroy) }
  end
end
