require "rails_helper"

RSpec.describe "Sign up" do
  context "when user sign up with empty name" do
    it "alerts proper error" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      expect(page).to have_content "Name can't be blank"
    end
  end

  context "when user sign up with empty email" do
    it "alerts proper error" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      expect(page).to have_content "Email can't be blank"
    end
  end

  context "when user sign up with an existing email" do
    let(:user) { create(:user) }

    it "alerts proper error" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_email", with: user.email
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      expect(page).to have_content "Email has already been taken"
    end

    context "when user sign up with empty password" do
      it "alerts proper error" do
        visit "/users/sign_up"
        within("#new_user") do
          fill_in "user_name", with: Faker::Name.name
          fill_in "user_email", with: Faker::Internet.email
        end
        click_button "Sign up"
        expect(page).to have_content "Password can't be blank"
      end
    end
  end

  context "when user sign up with short password" do
    it "alerts proper error" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "test"
        fill_in "user_password_confirmation", with: "test"
      end
      click_button "Sign up"
      expect(page).to have_content "Password is too short (minimum is 6 characters)"
    end
  end

  context "when user sign up with unmatched passwords" do
    it "alerts proper error" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "test123456"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      expect(page).to have_content "Password confirmation doesn't match Password"
    end
  end

  context "when correct details" do
    it "redirects to home page with success message" do
      visit "/users/sign_up"
      within("#new_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_email", with: Faker::Internet.email
        fill_in "user_password", with: "test1234"
        fill_in "user_password_confirmation", with: "test1234"
      end
      click_button "Sign up"
      expect(page).to have_content "Welcome! You have signed up successfully."
    end
  end
end
