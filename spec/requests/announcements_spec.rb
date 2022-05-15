require "rails_helper"

RSpec.describe "/announcements", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Announcement. As you add validations to Announcement, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { announcement_type: "new", name: Faker::Lorem.words(number: rand(2..3)).join(" "),
      description: Faker::Lorem.words(number: rand(2..10)).join(" ") }
  }

  describe "GET /index" do
    it "renders a successful response" do
      Announcement.create! valid_attributes
      get articles_url
      expect(response).to be_successful
    end
  end
end
