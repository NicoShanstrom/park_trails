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

    describe 'User story 10' do
        it 'renders a link on the asheville park show page to take a user to the trails of the park' do
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # User Story 10, Parent Child Index Link
            # As a visitor
            # When I visit a parent show page ('/parents/:id')
            visit "/asheville_parks/#{biltmore.id}"
            # Then I see a link to take me to that parent's `child_table_name` page ('/parents/:id/child_table_name')
            expect(page).to have_link("Show me #{biltmore.name} Trails!")
        end
    end

    describe 'User story 12' do
        it 'creates a link to edit an Asheville Park attributes' do
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            # User Story 12, Parent Update 
            # As a visitor
            # When I visit a parent show page
            visit "/asheville_parks/#{arboretum.id}"
            # Then I see a link to update the parent "Update Parent"
            expect(page).to have_link("Edit #{arboretum.name}!")
            # When I click the link "Update Parent"
            click_link("Edit #{arboretum.name}!")
            # Then I am taken to '/parents/:id/edit' where I  see a form to edit the parent's attributes:
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}/edit")
            expect(page).to have_selector('form')
            # When I fill out the form with updated information
            fill_in 'Name', with: 'North Carolina Arboretum'
            fill_in 'Fee', with: 0
            expect(page).to have_checked_field('Pets allowed')
            # save_and_open_page
            uncheck 'Pets allowed'
            # And I click the button to submit the form
            click_on "Update #{arboretum.name}"
            # Then a `PATCH` request is sent to '/parents/:id',
            # the parent's info is updated,
            # and I am redirected to the Parent's Show page where I see the parent's updated info
            expect(current_path).to eq("/asheville_parks/#{arboretum.id}")
            expect(page).to have_content('Pets allowed?: false')
        end
    end

    describe 'user story 19' do
        it 'renders a link to delete an asheville park' do
            malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
            malv_1 = malvern.trails.create!(name: "Malvern Hills Loop", paved: true, total_length: 1)
            malv_2 = malvern.trails.create!(name: "Home to Malvern Hills Park", paved: true, total_length: 1)
            # User Story 19, Parent Delete
            # As a visitor
            # When I visit a parent show page
            visit "/asheville_parks/#{malvern.id}"
            # Then I see a link to delete the parent
            expect(page).to have_link("Delete #{malvern.name}!")
            # When I click the link "Delete Parent"
            click_link("Delete #{malvern.name}!")
            # Then a 'DELETE' request is sent to '/parents/:id',
            # the parent is deleted, and all child records are deleted
            # and I am redirected to the parent index page where I no longer see this parent
            expect(current_path).to eq('/asheville_parks')
            expect(page).to_not have_content(malvern.name)
            visit("/asheville_parks/#{malvern.id}/trails")
            expect(page).to_not have_content(malv_1.name)
            expect(page).to_not have_content(malv_2.name)
            visit("/trails")
            expect(page).to_not have_content(malv_1.name)
            expect(page).to_not have_content(malv_2.name)
        end
    end
end