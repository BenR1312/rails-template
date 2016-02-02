class Company < ActiveRecord::Base

  acts_as_paranoid

  mount_uploader :banner_image, BannerImageUploader
  mount_uploader :logo, LogoUploader
  has_many :sponsors
  accepts_nested_attributes_for :sponsors

  validates :name, uniqueness: true, presence: true
  validates :country, presence: true
  validates :slogan, presence: true
  
end
