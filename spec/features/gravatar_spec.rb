require "rails_helper"

RSpec.describe "Gravatar" do
  context "when user sign up" do
    let!(:name) { Faker::Name.name }
    let!(:gravatar) { name.split.first(2).map(&:first).join }

    it "displays gravatar with initials" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      sleep(1)
      expect(page).to have_css(".avatar-text", text: gravatar)
    end
  end

  context "when user sign up who already have a gravatar image at gravatar website" do
    it "shows the image from gravatar website" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_email", with: "emmanuvarghese@gmail.com"
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      sleep(2)
      expect(page).to have_css("img.avatar-circle")
    end
  end

  context "when error happens while fetching the image from gravatar website" do
    let!(:name) { Faker::Name.name }
    let!(:gravatar) { name.split.first(2).map(&:first).join }

    before do
      allow(Digest::MD5).to receive(:hexdigest).and_raise(StandardError)
    end

    it "displays gravatar with initials" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: name
        fill_in "user_email", with: "emmanuvarghese@gmail.com"
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      sleep(1)
      expect(page).to have_css(".avatar-text", text: gravatar)
    end
  end
end
