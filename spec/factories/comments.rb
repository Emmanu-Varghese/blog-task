FactoryBot.define do
  factory :comment do
    commentable { create(:article) }
    body { Faker::Lorem.words(number: rand(2..10)).join(" ") }
    user
  end
end
