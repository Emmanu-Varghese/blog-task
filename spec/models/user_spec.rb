# spec/models/User_spec.rb

require "rails_helper"

RSpec.describe User, type: :model do
  it "is not valid without a name" do
    expect(build(:user, name: nil)).not_to be_valid
  end

  it "is not valid without a email" do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it "is not valid without a password" do
    expect(build(:user, password: nil)).not_to be_valid
  end

  it "is not valid if email is already taken" do
    user = create(:user)
    expect(build(:user, email: user.email)).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end
end
