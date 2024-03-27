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
            # find('input[name="trail[paved]"]').uncheck
            # save_and_open_page
            uncheck 'Paved'
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

    describe 'User story 16' do
        it 'contains a link to sort asheville park trails in alphabetical order' do
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            arbor_3 = arboretum.trails.create!(name:"Owl Ridge Trail", paved: false, total_length: 5)
            # User Story 16, Sort Parent's Children in Alphabetical Order by name 
            # As a visitor
            # When I visit the Parent's children Index Page
            visit "/asheville_parks/#{arboretum.id}/trails"
            # Then I see a link to sort children in alphabetical order
            expect(page).to have_link("Order trails alphabetically!")
            # When I click on the link
            click_link("Order trails alphabetically!")
            # I'm taken back to the Parent's children Index Page where I see all of the parent's children in alphabetical order
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}/trails")
            expect(arboretum.trails.alphabetical).to eq([arbor_2, arbor_1, arbor_3])
        end
    end

    describe 'user story 21' do
        it 'contains a form to filter trails over a user inputted trail total length' do
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            arbor_3 = arboretum.trails.create!(name:"Owl Ridge Trail", paved: false, total_length: 5)
            # User Story 21, Display Records Over a Given Threshold 
            # As a visitor
            # When I visit the Parent's children Index Page
            visit "/asheville_parks/#{arboretum.id}/trails"
            # I see a form that allows me to input a number value
            expect(page).to have_selector('form')
            # When I input a number value and click the submit button that reads 'Only return records with more than `number` of `column_name`'
            fill_in 'Filter trails by minimum total length (miles):', with: 4
            click_on 'Filter'
            # Then I am brought back to the current index page with only the records that meet that threshold shown.
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}/trails")
            expect(page).to have_content(arbor_2.name)
            expect(page).to have_content(arbor_3.name)
            expect(page).not_to have_content(arbor_1.name)
        end
    end
end
