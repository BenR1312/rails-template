class Sponsor < ActiveRecord::Base
 
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true

end
