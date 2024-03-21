# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#seed asheville_parks and trails
Trail.destroy_all
AshevillePark.destroy_all
malvern = AshevillePark.create!(name: "Malvern Hills", fee: 0, pets_allowed: true)
arboretum = AshevillePark.create!(name: "North Carolina Arboretum", fee: 15, pets_allowed: true)
biltmore = AshevillePark.create!(name: "Biltmore Estate", fee: 20, pets_allowed: false)

malv_1 = malvern.trails.create!(name: "Malvern Hills Loop", paved: true, total_length: 1)
malv_2 = malvern.trails.create!(name: "Home to Malvern Hills Park", paved: true, total_length: 1)
arbor_1 = arboretum.trails.create!(name:"Natural Garden Loop", paved: false, total_length: 3)
arbor_2 = arboretum.trails.create!(name:"Lake Powhatan via Bent Creek", paved: false, total_length: 6)
bilt_1 = biltmore.trails.create!(name:"Biltmore Estate Path Loop", paved: false, total_length: 3)
bilt_2 = biltmore.trails.create!(name:"Gardens and Conservatory", paved: true, total_length: 3)