require 'rails_helper'

RSpec.describe 'asheville_parks #show' do
    describe 'user story 2' do
        it 'shows the Asheville Park of the requested :id and its attributes' do
            # User Story 2, Parent Show 
            malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)
            # As a visitor
            # When I visit '/parents/:id'
            visit "/asheville_parks/#{malvern.id}"
            # Then I see the parent with that id including the parent's attributes
            # (data from each column that is on the parent table)
            expect(page).to have_content("Fee:")
            expect(page).to have_content("Pets allowed?:")
            expect(page).to have_content(malvern.name)
            expect(page).to have_content(malvern.fee)
            expect(page).to have_content(malvern.pets_allowed)
            expect(page).to_not have_content(arboretum.name)
        end
    end

    describe 'User story 7' do
        it 'shows a count of trails associated with this specific park' do
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # As a visitor
            # When I visit a parent's show page
            visit "asheville_parks/#{biltmore.id}"
            # I see a count of the number of children associated with this parent
            expect(page).to have_content("Number of Trails: #{biltmore.trail_count}")
            
        end
    end
end