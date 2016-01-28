class Site < ActiveRecord::Base

  belongs_to :address
  accepts_nested_attributes_for :address
  
  
  has_and_belongs_to_many :trucks




  scope :named, -> (site_name) { where("sites.name ILIKE ?", "%#{site_name}%") }

  # Ensure that a Site has an address and a name
  validates :name, presence: true
  validates :address, presence: true

  def to_s
    name
  end

end
