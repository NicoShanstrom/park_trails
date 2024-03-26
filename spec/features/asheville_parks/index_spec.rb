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
            expect(page).to have_content("Park name: Malvern Hills")
            expect(page).to have_content("Park name: Biltmore Estate")
            expect(page).to have_content("Park name: North Carolina Arboretum")
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
      # expect(AshevillePark.ordered_parks).to eq([biltmore, arboretum, malvern])
      expect(biltmore.name).to appear_before(arboretum.name)
      expect(arboretum.name).to appear_before(malvern.name)
      # And next to each of the records I see when it was created
      expect(page).to have_content("Time created:")
      expect(page).to have_content(malvern.created_at)
      expect(page).to have_content(arboretum.created_at)
      expect(page).to have_content(biltmore.created_at)
    end
  end

  describe 'User story 9' do
    it 'displays a link at the top of any page to link to asheville parks index' do
      # User Story 9, Parent Index Link
      # As a visitor
      # When I visit any page on the site
      visit '/trails'
      # Then I see a link at the top of the page that takes me to the Parent Index
      expect(page).to have_link('Show me all Asheville Parks!')

      visit '/asheville_parks'
      expect(page).to have_link('Show me all Asheville Parks!')
    end
  end

  describe 'Story 11' do
    it 'renders a link to create a new Asheville Park in Asheville Parks index' do
      # User Story 11, Parent Creation 
      # As a visitor
      # When I visit the Parent Index page
      visit '/asheville_parks'
      # Then I see a link to create a new Parent record, "New Parent"
      expect(page).to have_link("Add an Asheville park!")
      # When I click this link
      click_link("Add an Asheville park!")
      # Then I am taken to '/parents/new' where I  see a form for a new parent record
      expect(current_path).to eq('/asheville_parks/new')
      expect(page).to have_selector('form')
      # When I fill out the form with a new parent's attributes:
      fill_in 'Name', with: 'Richmond Hill Park'
      fill_in 'Fee', with: 0
      check 'Pets allowed'
      # And I click the button "Create Parent" to submit the form
      click_on 'Create Asheville Park!'
      # Then a `POST` request is sent to the '/parents' route,
      # a new parent record is created,
      # and I am redirected to the Parent Index page where I see the new Parent displayed.
      expect(current_path).to eq('/asheville_parks')
      expect(page).to have_content('Richmond Hill Park')
    end
  end

  describe 'user story 17' do
    it 'renders a link next to each park to edit its info' do
      arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
      # User Story 17, Parent Update From Parent Index Page 
      # As a visitor
      # When I visit the parent index page
      visit '/asheville_parks'
      # Next to every parent, I see a link to edit that parent's info
      expect(page).to have_content(arboretum.name)
      expect(page).to have_content(arboretum.created_at)
      expect(page).to have_link("Edit #{arboretum.name}")
      # When I click the link
      click_link("Edit #{arboretum.name}")
      # I should be taken to that parent's edit page where I can update its information just like in User Story 12
      expect(current_path).to eq("/asheville_parks/#{arboretum.id}/edit")
    end
  end
end