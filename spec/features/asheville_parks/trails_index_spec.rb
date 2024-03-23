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

    describe 'User story 13' do
        it 'Renders a link on the trail list of a park to add a new trail to the park' do
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            # User Story 13, Parent Child Creation 
            # As a visitor
            # When I visit a Parent Children Index page
            visit "/asheville_parks/#{arboretum.id}/trails"
            # Then I see a link to add a new child for that parent "Create Child"
            expect(page).to have_link("Add trail to #{arboretum.name}!")
            # When I click the link
            click_link("Add trail to #{arboretum.name}!")
            # I am taken to '/parents/:parent_id/child_table_name/new' where I see a form to add a new child
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}/trails/new")
            expect(page).to have_selector('form')
            # When I fill in the form with the child's attributes:
            fill_in 'Name', with: 'Carolina Mountain'
            find('input[name="trail[paved]"]').uncheck
            # uncheck 'trail[paved]'
            fill_in 'Total length in miles', with: 2
            # And I click the button "Create Child"
            click_on "Create new trail in #{arboretum.name}!"
            # Then a `POST` request is sent to '/parents/:parent_id/child_table_name',
            # a new child object/row is created for that parent,
            # and I am redirected to the Parent Childs Index page where I can see the new child listed
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}/trails")
            expect(page).to have_content('Carolina Mountain')
        end 
    end
end
