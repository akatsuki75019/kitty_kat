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

#Mon stock d'images celui contenu dans assets/images
image_array = ["avatar 2.jpeg", "avatar 3.jpeg", "avatar 4.jpeg", "cat 2.jpeg", "cat 3.jpeg", "cat chill.jpeg", "cat reading.jpeg", "cat samurai 1.webp", "cat samurai 2.jpeg", "chat de race.jpeg", "chat long poils.webp", "chat samurai 1.png", "chaton_achat.png", "chaton_sur-dos.jpeg", "christmas_cat_sm.webp", "cute_cat_square.jpeg", "fat_cat.jpg", "funny_cat_sm.jpeg", "kittens.jpeg", "rock_cat_sm.avif", "Sphynx.webp"]

# Pour mixer un peu l'ordre des images
shuffled_images = image_array.shuffle

21.times do |image|
  Item.create(
    title: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph,
    price: Faker::Commerce.price(range: 1.00..20.00),
    image_url: shuffled_images[image]
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