FactoryBot.define do
  factory :article do
    title { Faker::Lorem.words(number: rand(2..5)).join(" ") }
    body { Faker::Lorem.words(number: rand(2..10)).join(" ") }
    user
  end
end
