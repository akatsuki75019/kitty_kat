# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
5.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 50..200),
    image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['item'])
  )
end

image_files = Dir.glob(Rails.root.join('app', 'assets', 'images', '*'))

image_files.each do |image_path|
  title = File.basename(image_path, '.*')
  Image.create!(
    title: title,
    image: File.open(image_path)
  )
end