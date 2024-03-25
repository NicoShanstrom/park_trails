class Trail < ApplicationRecord
  belongs_to :asheville_park

  def self.paved_trails
    where(paved: true)
  end
end
