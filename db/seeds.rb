# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Starting seeding"
puts "Adding city records to database"
require 'csv'
cities_filepath = "#{Rails.root}/db/seeds/cities.csv"
CSV.foreach(cities_filepath, headers: true) do |row|
  city = City.find_or_initialize_by(name: row["name"], country_code: row["country_code"])
  city.save!
end
puts "Fetching location details from geocoding API asynchronously"
City.all.each do |city|
  FetchAndUpdateCityDataJob.perform_async(city.id)
end
puts "Seeding complete"
