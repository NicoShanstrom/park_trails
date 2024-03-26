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
                within("#trail-#{trail.id}") do
                    expect(page).to have_content(trail.name)
                    expect(page).to have_content(trail.paved)
                    expect(page).to have_content(trail.total_length)
                    expect(page).to have_content(trail.asheville_park.name)
                end
            end
        end
    end

    describe 'user story 8' do
       it 'shows a link to trails index on the top of any page' do
        # User Story 8, Child Index Link
        # As a visitor
        # When I visit any page on the site
        visit '/asheville_parks'
        # Then I see a link at the top of the page that takes me to the Child Index
        expect(page).to have_link('Show me all the trails!')

        visit '/trails'
        expect(page).to have_link('Show me all the trails!')
       end
    end

    describe 'user story 15' do
        it 'only shows trails where paved is true' do
            malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
            arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            malv_1 = malvern.trails.create!(name: "Malvern Hills Loop", paved: true, total_length: 1)
            malv_2 = malvern.trails.create!(name: "Home to Malvern Hills Park", paved: true, total_length: 1)
            arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
            arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # User Story 15, Child Index only shows `true` Records 
            # As a visitor
            # When I visit the child index
            visit '/trails'
            expect(page).to have_link("Show all trails!")
            expect(page).to have_link("Show only paved trails!")
            click_link("Show only paved trails!")
            # expect(current_path).to eq("/trails?paved=true")
            # Then I only see records where the paved column is `true`
            expect(page).to have_content(malv_1.name)
            expect(page).to have_content(malv_2.name)
            expect(page).to have_content(bilt_2.name)
            expect(page).to_not have_content(bilt_1.name)
            expect(page).to_not have_content(arbor_1.name)
            expect(page).to_not have_content(arbor_2.name)
        end
    end

    describe 'user story 18' do
        it 'renders a link next to each trail to edit its info' do
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # User Story 18, Child Update From Childs Index Page 
            # As a visitor
            # When I visit the `child_table_name` index page or a parent `child_table_name` index page
            visit '/trails'
            # Next to every child, I see a link to edit that child's info
            expect(page).to have_content(bilt_1.name)
            expect(page).to have_content(bilt_1.name)
            expect(page).to have_content(bilt_1.total_length)
            expect(page).to have_content(bilt_2.name)
            expect(page).to have_content(bilt_2.name)
            expect(page).to have_content(bilt_2.total_length)

            expect(page).to have_link("Edit #{bilt_1.name}")
            expect(page).to have_link("Edit #{bilt_2.name}")
            # When I click the link
            click_link("Edit #{bilt_1.name}")
            # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
            expect(current_path).to eq("/trails/#{bilt_1.id}/edit")
        end

        it 'User story 18 part 2: renders a link next to each asheville park trail to edit its info' do
            biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

            bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
            bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)
            # User Story 18, Child Update From Childs Index Page 
            # As a visitor
            # When I visit the `child_table_name` index page or a parent `child_table_name` index page
            visit "/asheville_parks/#{biltmore.id}/trails"
            # Next to every child, I see a link to edit that child's info
            expect(page).to have_content(bilt_1.name)
            expect(page).to have_content(bilt_1.name)
            expect(page).to have_content(bilt_1.total_length)
            expect(page).to have_content(bilt_2.name)
            expect(page).to have_content(bilt_2.name)
            expect(page).to have_content(bilt_2.total_length)

            expect(page).to have_link("Edit #{bilt_1.name}")
            expect(page).to have_link("Edit #{bilt_2.name}")
            # When I click the link
            click_link("Edit #{bilt_1.name}")
            # I should be taken to that `child_table_name` edit page where I can update its information just like in User Story 14
            expect(current_path).to eq("/trails/#{bilt_1.id}/edit")
        end
    end
end