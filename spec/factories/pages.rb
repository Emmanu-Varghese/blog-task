# frozen_string_literal: true

FactoryBot.define do
  factory :page do
    title { Faker::Name.name }
    body { Faker::Lorem.words(number: rand(2..10)) }
  end
end
