require 'rails_helper'

RSpec.describe 'trails #show' do
    describe 'user story 14' do
        it 'contains a link that when clicked renders a form to update trail attributes' do
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)
            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)

            # User Story 14, Child Update 
            # As a visitor
            # When I visit a Child Show page
            visit "/trails/#{bilt_1.id}"
            # Then I see a link to update that Child "Update Child"
            expect(page).to have_link("Edit #{bilt_1.name}!")
            # When I click the link
            click_link("Edit #{bilt_1.name}!")
            # I am taken to '/child_table_name/:id/edit' where I see a form to edit the child's attributes:
            expect(current_path).to eq("/trails/#{bilt_1.id}/edit")
            expect(page).to have_selector('form')
            expect(page).to have_content("Name")
            expect(page).to have_field("Paved", type: "checkbox")
            expect(page).to have_content("Total length in miles:")
            # When I click the button to submit the form "Update Child"
            click_on 'Update trail'
            # Then a `PATCH` request is sent to '/child_table_name/:id',
            # the child's data is updated,
            # and I am redirected to the Child Show page where I see the Child's updated information
            expect(current_path).to eq("/trails/#{bilt_1.id}")
        end
    end
end