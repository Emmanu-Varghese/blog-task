require "rails_helper"

RSpec.describe Article, type: :model do
  it "is not valid without a title" do
    expect(build(:article, title: nil)).not_to be_valid
  end

  it "is not valid without a body" do
    expect(build(:article, body: nil)).not_to be_valid
  end

  it "is not valid without a user" do
    expect(build(:article, user: nil)).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(build(:article)).to be_valid
  end
end
