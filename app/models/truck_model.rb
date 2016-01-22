class TruckModel < ActiveRecord::Base

  def to_s
    name
  end

  validates :name, presence: true

end

