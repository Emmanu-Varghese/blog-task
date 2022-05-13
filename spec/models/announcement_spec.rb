# spec/models/announcement_spec.rb

require "rails_helper"

RSpec.describe Announcement, type: :model do
  it "is not valid without a announcement type" do
    expect(build(:announcement, announcement_type: nil)).not_to be_valid
  end

  it "is not valid without a description" do
    expect(build(:announcement, description: nil)).not_to be_valid
  end

  it "is not valid without a name" do
    expect(build(:announcement, name: nil)).not_to be_valid
  end

  it "is not valid without a published_at" do
    expect(build(:announcement, published_at: nil)).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(build(:announcement)).to be_valid
  end
end
