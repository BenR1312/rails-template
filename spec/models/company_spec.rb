require 'rails_helper'

RSpec.describe Company, type: :model do

  describe "@name" do
    before { FactoryGirl.create(:company) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:name) }
  end

  describe "@country" do
    it { should validate_presence_of(:country) }
  end

  describe "@slogan" do
    it { should validate_presence_of(:slogan) }
  end
end
