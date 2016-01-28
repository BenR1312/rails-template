require 'rails_helper'

RSpec.describe Truck, type: :model do

  describe "@registration" do
    it { should validate_presence_of(:registration) }
  end

  describe "@truck_model" do
    it { should validate_presence_of(:truck_model) }
  end
  
  describe "@driver" do
    it { should validate_presence_of(:driver) }
  end
  

end
