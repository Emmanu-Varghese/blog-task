# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Emmanu Varghese", email: "emmanuvarghese@gmail.com", password: "123456", admin: true)
50.times do |i|
	User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end
50.times do |i|
	Announcement.create!(announcement_type: 'fix', name: Faker::Name.name, description: Faker::Lorem.words(number: rand(2..10)).join(" "))
end
50.times do |i|
	Announcement.create!(announcement_type: 'new', name: Faker::Name.name, description: Faker::Lorem.words(number: rand(2..10)).join(" "))
end