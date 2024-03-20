require 'rails_helper'

RSpec.describe 'trails index' do
    describe 'user story 3' do
        it 'Renders all trails in the system including their attributes' do
            # User Story 3, Child Index
            malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            malv_1 = malvern.trails.create!(name: "Malvern Hills Loop", paved: true, total_length: 1)
            malv_2 = malvern.trails.create!(name: "Home to Malvern Hills Park", paved: true, total_length: 1)
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # As a visitor
            # When I visit '/child_table_name'
            visit '/trails'
            # Then I see each Child in the system including the Child's attributes
            # (data from each column that is on the child table)
            [malv_1, malv_2, arbor_1, arbor_2, bilt_1, bilt_2].each do |trail|
                expect(page).to have_content(trail.name)
                expect(page).to have_content(trail.paved)
                expect(page).to have_content(trail.total_length)
                expect(page).to have_content(trail.asheville_park.name)
            end
        end
    end
end