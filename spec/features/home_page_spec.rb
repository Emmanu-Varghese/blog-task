require "rails_helper"

RSpec.describe "Home page" do
  context "when user visits home page" do
    it "shows the main heading" do
      visit "/"
      expect(page).to have_content "Simple Blog!"
    end

    it "shows the learn more button" do
      visit "/"
      expect(page).to have_content "Write a Blog"
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

  context "when user clicks write a blog without login" do
    it "redirects to home page and see warning" do
      visit "/"
      click_link "Write a Blog"
      sleep(2)
      expect(page).to have_content("You are not authorized to access this page.")
    end
  end

  context "when logged in user clicks write a blog" do
    let!(:user) { create(:user, password: "test1234") }

    it "redirects to home page and see warning" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(2)
      visit "/"
      click_link "Write a Blog"
      sleep(2)
      expect(page).to have_current_path(new_article_path)
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

  context "when no articles are there and user visits home page" do
    it "No articles to show alert is displayed" do
      visit "/"
      expect(page).to have_content("No articles to show!")
    end
  end

  context "when user filter articles by user" do
    let!(:user1) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:article1) { create(:article, user_id: user1.id) }
    let!(:article2) { create(:article, user_id: user2.id) }

    it "shows all articles by default" do
      visit "/"
      expect(page).to have_content(article1.title)
      expect(page).to have_content(article2.title)
    end

    it "shows the articles of the selected user" do
      visit "/"
      select user2.first_name, from: "user_id"
      expect(page).not_to have_content(article1.title)
      expect(page).to have_content(article2.title)
    end
  end
end
