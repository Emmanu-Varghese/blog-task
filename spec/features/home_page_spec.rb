require "rails_helper"

RSpec.describe "Home page" do
  context "when user visits home page" do
    it "shows the main heading" do
      visit "/"
      expect(page).to have_content "Simple Blog!"
    end

    it "shows the learn more button" do
      visit "/"
      expect(page).to have_content "Learn More"
    end

    it "shows the Filter by user text" do
      visit "/"
      expect(page).to have_content "Filter by user"
    end

    it "shows copyright at the bottom" do
      visit "/"
      expect(page).to have_content "© 2022 blog"
    end
  end

  context "when user click sign up link in the home page" do
    it "redirects to sign up page" do
      visit "/"
      click_link "Sign Up"
      expect(page).to have_current_path(new_user_registration_path)
    end
  end

  context "when user click login link in the home page" do
    it "redirects to login page" do
      visit "/"
      click_link "Login"
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context "when user click whats new link in the home page" do
    it "redirects to announcements page" do
      visit "/"
      click_link "What's New"
      expect(page).to have_current_path(announcements_path)
    end
  end
end
