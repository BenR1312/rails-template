class FleetTruck < ActiveRecord::Base

  belongs_to :truck
  belongs_to :fleet

  # validates :truck, uniqueness: true
  # validates_uniqueness_of :truck, :scope => [:registration]
  validates :truck_id, uniqueness: {scope: :fleet_id} 
  validates :status, presence: true
  
end
