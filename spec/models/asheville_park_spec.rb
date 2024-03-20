require 'rails_helper'

RSpec.describe AshevillePark, type: :model do
  describe "relationships" do
    it { should have_many(:trails) }
  end

  describe "#ordered_parks" do
    it 'orders parks by most recently created first' do
      malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
      arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
      biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

      expect(AshevillePark.ordered_parks).to eq([biltmore, arboretum, malvern])
    end
  end
end
