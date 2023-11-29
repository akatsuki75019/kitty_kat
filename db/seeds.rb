require 'faker'

# Create an hash with associated last and first name
team_players = [
  ["Nellote", "thehacking1"],
  ["Flo", "thehacking2"],
  ["Sam", "thehacking3"],
  ["Alex", "thehacking4"],
  ["Axel", "thehacking5"],
  ["Vincent", "thehacking5"]
]

#now create each user
team_players.shuffle.each do |player|
  first_name = player[0]
  password = player[1]

  email = "#{first_name.tr(' ', '_').tr('é', 'e').tr('î', 'i')}@yopmail.com"
  # tr replace space in last name by underscore

  User.create!(
    email: email,
    password: password)
end



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