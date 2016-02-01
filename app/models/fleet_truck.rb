class FleetTruck < ActiveRecord::Base

  belongs_to :truck
  belongs_to :fleet, inverse_of: :fleet_trucks

  validates :truck_id, uniqueness: {scope: :fleet_id} 
  validates :status, presence: true, inclusion: { in: ["standard", "auxiliary"] }
  
end
