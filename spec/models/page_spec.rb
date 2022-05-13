# spec/models/page_spec.rb

require "rails_helper"

RSpec.describe Page, type: :model do
  it "is not valid without a title" do
    expect(build(:page, title: nil)).not_to be_valid
  end

  it "is not valid without a body" do
    expect(build(:page, body: nil)).not_to be_valid
  end

  it "is valid with valid attributes" do
    expect(build(:page)).to be_valid
  end
end
