class Company < ActiveRecord::Base
  mount_uploader :company_banner, CompanyBannerUploader
  mount_uploader :company_logo, CompanyLogoUploader
  has_many :sponsors

  validates :name, uniqueness: true, presence: true
  validates :country, presence: true
  validates :slogan, presence: true
  
end
