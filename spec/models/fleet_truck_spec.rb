require 'rails_helper'

RSpec.describe FleetTruck, type: :model do
  
  describe "@status" do
    it { should validate_presence_of(:status) }
  end

  describe "@truck_id" do
    it "prevents a Truck from being assigned to the same Fleet twice" do
      fleet = FactoryGirl.create(:fleet)
      truck = FactoryGirl.create(:truck)

      existing_fleet_truck = FactoryGirl.build(:fleet_truck, fleet: fleet, truck: truck)
      existing_fleet_truck.save
      expect(existing_fleet_truck).to be_valid

      duplicate = FactoryGirl.build(:fleet_truck, fleet: fleet, truck: truck)
      expect(duplicate).to be_invalid
      expect(duplicate.errors[:truck_id].count).to eq(1)
    end
  end

end
