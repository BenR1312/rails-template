class Fleet < ActiveRecord::Base
  
  acts_as_paranoid
  
  has_many :fleet_trucks, inverse_of: :fleet
  has_many :trucks, through: :fleet_trucks

  accepts_nested_attributes_for :fleet_trucks, allow_destroy: true
  validates_associated :fleet_trucks
  validates :fleet_name, presence: true

  # We need to manually ensure the uniqueness of Truck ids because when a Fleet is being
  # created it will not have an id for the FleetTruck object to validate against
  #
  # This call must be under the validates_associated(:fleet_trucks), because that validation
  # will remove any errors we manually add to the FleetTruck objects
  validate :unique_truck_ids

private

  def has_duplicate_truck_ids?
    truck_ids = fleet_trucks.map(&:truck_id)
    truck_ids != truck_ids.uniq
  end

  def unique_truck_ids
    if has_duplicate_truck_ids?
      # Ensure error message will be visible of Fleet form
      fleet_trucks.each do |fleet_truck|
        fleet_truck.errors.add(:truck, "You cannot assign the same Truck multiple times")
      end
      # Since validates_associated will be called before this validation, we need to force
      # this Fleet to be invalid by setting and error
      errors.add(:fleet_trucks, "You cannot assign the same Truck multiple times")
    end
  end
end
