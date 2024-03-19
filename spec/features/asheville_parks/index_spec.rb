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
            expect(page).to have_content("Malvern Hills")
            expect(page).to have_content("Biltmore Estate")
            expect(page).to have_content("North Carolina Arboretum")
        end
    end
end