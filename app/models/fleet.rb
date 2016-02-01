class Fleet < ActiveRecord::Base
  
  acts_as_paranoid
  
  has_many :fleet_trucks, inverse_of: :fleet
  has_many :trucks, through: :fleet_trucks

  accepts_nested_attributes_for :fleet_trucks, allow_destroy: true
  validates_associated :fleet_trucks
  validates :fleet_name, presence: true

  validate :unique_truck_ids

private

  def has_duplicate_truck_ids?
    truck_ids = fleet_trucks.map(&:truck_id)
    truck_ids != truck_ids.uniq
  end

  def unique_truck_ids
    if has_duplicate_truck_ids?
      # adds error message for truck
      fleet_trucks.each do |fleet_truck|
        fleet_truck.errors.add(:truck, "You cannot assign the same Truck multiple times")
      end
      # required to call error on trucks, because of associations
      errors.add(:fleet_trucks, "You cannot assign the same Truck multiple times")
    end
  end
end
