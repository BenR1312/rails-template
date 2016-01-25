class Truck < ActiveRecord::Base
  
  belongs_to :truck_model
  belongs_to :driver, class_name: User

  has_and_belongs_to_many :sites
  
  validates :registration, presence: true
  validates :truck_model, presence: true
  validates :driver, presence: true

end
