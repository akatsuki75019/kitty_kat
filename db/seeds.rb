require 'faker'

10.times do
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 1.00..20.00),
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