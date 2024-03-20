require 'rails_helper'

RSpec.describe 'Asheville Parks trails index' do
    describe 'user story 5' do
        it 'renders each trail and its attributes associated with a specific park' do
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            
            # User Story 5, Parent Children Index
            # As a visitor
            # When I visit '/parents/:parent_id/child_table_name'
            visit "/asheville_parks/#{arboretum.id}/trails"
            # Then I see each Child that is associated with that Parent with each Child's attributes
            # (data from each column that is on the child table)
            [arbor_1, arbor_2].each do |trail|
                expect(page).to have_content(trail.name)
                expect(page).to have_content(trail.paved)
                expect(page).to have_content(trail.total_length)
            end
        end
    end
end
