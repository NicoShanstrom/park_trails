require 'rails_helper'

RSpec.describe AshevillePark, type: :model do
  describe "relationships" do
    it { should have_many(:trails) }
  end

  describe "#self.ordered_parks" do
    it 'orders parks by most recently created first' do
      malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
      arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
      biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

      expect(AshevillePark.ordered_parks).to eq([biltmore, arboretum, malvern])
    end
  end

  describe "#trail_count" do
    it 'counts trails associated with a specific park' do
      biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

      bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
      bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)

      expect(biltmore.trail_count).to eq(2)
    end
  end
end
