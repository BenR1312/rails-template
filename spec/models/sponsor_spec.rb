require 'rails_helper'

RSpec.describe Sponsor, type: :model do

  describe "@name" do
    it { should validate_presence_of(:name) }
  end

  describe "@description" do
    it { should validate_presence_of(:description) }
  end
end
