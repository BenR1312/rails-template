class Fleet < ActiveRecord::Base
  
  acts_as_paranoid
  
  has_many :fleet_trucks
  has_many :trucks, through: :fleet_trucks

  accepts_nested_attributes_for :fleet_trucks, allow_destroy: true
  validates_associated :fleet_trucks
  validates :fleet_name, presence: true
end
