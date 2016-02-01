require 'rails_helper'

RSpec.describe Fleet, type: :model do

  describe "@fleet_name" do
    it { should validate_presence_of(:fleet_name) }
  end
end
