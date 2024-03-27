class Trail < ApplicationRecord
  belongs_to :asheville_park

  def self.paved_trails
    where(paved: true)
  end

  def self.alphabetical
    self.order(:name)
  end

  def self.minimum_length(min_length)
    where("total_length >= ?", min_length)
  end
end
