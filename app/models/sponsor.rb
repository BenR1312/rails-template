class Sponsor < ActiveRecord::Base
  mount_uploader :logo, LogoUploader
  belongs_to :company

  validates :name, presence: true
  validates :description, presence: true

end
