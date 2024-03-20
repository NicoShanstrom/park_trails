require 'rails_helper'

RSpec.describe 'asheville_parks index' do
    describe 'user story 1' do
        it 'shows the name of each asheville park in the system' do
            # User Story 1, Parent Index 
            # For each parent table
            malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)
            # As a visitor
            # When I visit '/parents'
            visit '/asheville_parks'
            # Then I see the name of each parent record in the system
            within "#all_parks" do
                expect(page).to have_content("Park name: Malvern Hills")
                expect(page).to have_content("Park name: Biltmore Estate")
                expect(page).to have_content("Park name: North Carolina Arboretum")
            end 
        end
    end

    describe 'User story 6' do
    it 'sorts asheville parks index by most recently created' do
      # User Story 6, Parent Index sorted by Most Recently Created 
      malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
      arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
      biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)
      # As a visitor
      # When I visit the parent index,
      visit '/asheville_parks'
      # I see that records are ordered by most recently created first
      expect(AshevillePark.ordered_parks).to eq([biltmore, arboretum, malvern])
      # And next to each of the records I see when it was created
      expect(page).to have_content("Time created:")
      expect(page).to have_content(malvern.created_at)
      expect(page).to have_content(arboretum.created_at)
      expect(page).to have_content(biltmore.created_at)
    end
  end
end