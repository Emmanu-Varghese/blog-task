require "rails_helper"

RSpec.describe "Sign in" do
  let(:user) { create(:user) }
  let(:other_user) { User.create(email: "other@example.com", password: "rous") }

  context "when user sign in with empty credentials" do
    it "alerts proper error" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: ""
        fill_in "user_password", with: ""
      end
      click_button "Log in"
      expect(page).to have_content "You need to sign in or sign up before continuing."
    end
  end

  context "when user sign in as another user" do
    it "alerts proper error" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: other_user.email
        fill_in "user_password", with: other_user.password
      end
      click_button "Log in"
      expect(page).to have_content "Invalid Email or password."
    end
  end

  context "when user sign in with correct credentials" do
    it "redirects to home page with success message" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(1)
      expect(page).to have_content "Signed in successfully."
    end
  end
end
