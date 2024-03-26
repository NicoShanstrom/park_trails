class Trail < ApplicationRecord
  belongs_to :asheville_park

  def self.paved_trails
    where(paved: true)
  end

  def self.alphabetical
      self.all.sort_by(&:name)
  end
end
