# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
User.create!(name: "Emmanu Varghese", email: "emmanuvarghese@gmail.com", password: "123456", admin: true)
5.times do |i|
	User.create!(name: Faker::Name.name, email: Faker::Internet.email, password: Faker::Internet.password)
end

users = User.all.pluck(:id)
15.times do
  [].tap do |array|
    5.times do
      time = Time.current
      array << {
        title: Faker::Lorem.words(number: rand(2..5)).join(" "),
        body: Faker::Lorem.words(number: rand(15..50)).join(" "),
        user_id: users.sample,
        updated_at: time,
        created_at: time
      }
    end
    Article.insert_all(array)
  end
end