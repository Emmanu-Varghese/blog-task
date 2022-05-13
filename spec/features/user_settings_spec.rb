require "rails_helper"

RSpec.describe "User settings" do
  context "when user visit user settings withou login" do
    it "redirects to home page and see warning" do
      visit "users/edit"
      expect(page).to have_content("You need to sign in or sign up before continuing.")
    end
  end

  context "when user login and visit user settings" do
    let!(:user) { create(:user, password: "test1234") }

    it "sees email" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      expect(page).to have_field("user_email", with: user.email)
    end

    it "sees name" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      expect(page).to have_field("user_name", with: user.name)
    end
  end

  context "when user update details without current password" do
    let!(:user) { create(:user, password: "test1234") }

    it "alerts that current password is needed" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      click_button "Save Changes"
      sleep(2)
      expect(page).to have_content("Current password can't be blank")
    end
  end

  context "when user update name" do
    let!(:user) { create(:user, password: "test1234") }

    it "redirects to home page with success message" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      within("#edit_user") do
        fill_in "user_name", with: Faker::Name.name
        fill_in "user_current_password", with: "test1234"
      end
      click_button "Save Changes"
      sleep(2)
      expect(page).to have_content("Your account has been updated successfully.")
    end

    it "updates name" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      within("#edit_user") do
        fill_in "user_name", with: "Test Name"
        fill_in "user_current_password", with: "test1234"
      end
      click_button "Save Changes"
      sleep(2)
      visit "users/edit"
      expect(page).to have_field("user_name", with: "Test Name")
    end
  end

  context "when user update password and the confirm password doesn't match" do
    let!(:user) { create(:user, password: "test1234") }

    it "alerts the error" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      within("#edit_user") do
        fill_in "user_password", with: "test12@"
        fill_in "user_password_confirmation", with: "test12#"
        fill_in "user_current_password", with: "test1234"
      end
      click_button "Save Changes"
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end

  context "when user update with short password" do
    let!(:user) { create(:user, password: "test1234") }

    it "alerts the error" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "users/edit"
      within("#edit_user") do
        fill_in "user_password", with: "test1"
        fill_in "user_password_confirmation", with: "test1"
        fill_in "user_current_password", with: "test1234"
      end
      click_button "Save Changes"
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
    end
  end
end
