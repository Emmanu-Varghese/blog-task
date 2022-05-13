# frozen_string_literal: true

FactoryBot.define do
  factory :announcement do
    published_at { Time.zone.now }
    announcement_type { "new" }
    name { Faker::Name.name }
    description { Faker::Lorem.words(number: rand(2..10)).join(" ") }
  end
end
