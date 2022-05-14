FactoryBot.define do
  factory :comment do
    commentable { create(:article) }
    user
  end
end
