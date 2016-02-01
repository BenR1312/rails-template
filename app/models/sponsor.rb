class Sponsor < ActiveRecord::Base
  mount_uploader :sponsor_logo, SponsorLogoUploader
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true

end
