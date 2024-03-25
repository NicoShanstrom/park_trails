require 'rails_helper'

RSpec.describe Trail, type: :model do
  describe "relationships" do
    it { should belong_to :asheville_park }
  end

  describe "#paved_trails" do
    it 'filters trails based on if paved is true' do
      malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
      arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
      biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

      malv_1 = malvern.trails.create!(name: "Malvern Hills Loop", paved: true, total_length: 1)
      malv_2 = malvern.trails.create!(name: "Home to Malvern Hills Park", paved: true, total_length: 1)
      arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
      arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
      bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
      bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)

      expect(Trail.paved_trails).to eq([malv_1, malv_2, bilt_2])
    end
  end
end
