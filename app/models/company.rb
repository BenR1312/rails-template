class Company < ActiveRecord::Base
  has_many :sponsors

  validates :name, uniqueness: true, presence: true
  validates :country, presence: true
  validates :slogan, presence: true
  
end
