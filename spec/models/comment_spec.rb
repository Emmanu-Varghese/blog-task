require "rails_helper"

RSpec.describe Comment, type: :model do
  it "is not valid without a commentable" do
    expect(build(:comment, commentable: nil)).not_to be_valid
  end

  it "is not valid without a user" do
    expect(build(:comment, user: nil)).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(build(:comment)).to be_valid
  end
end
