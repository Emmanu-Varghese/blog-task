require "rails_helper"

RSpec.describe "Articles" do
  let!(:user) { create(:user, password: "test1234") }

  before do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
    end
    click_button "Log in"
    sleep(2)
  end

  context "when user creates a new article with empty title" do
    it "shows the error message" do
      visit "/articles/new"
      fill_in "article_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Article"
      sleep(1)
      expect(page).to have_content("Title can't be blank")
    end
  end

  context "when user creates a new article with empty body" do
    it "shows the error message" do
      visit "/articles/new"
      fill_in "article_title", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Article"
      sleep(1)
      expect(page).to have_content("Body can't be blank")
    end
  end

  context "when user creates a new article" do
    it "redirect to article show page" do
      visit "/articles/new"
      fill_in "article_title", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      fill_in "article_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Article"
      sleep(1)
      expect(page).to have_current_path(article_path(Article.last))
    end
  end

  context "when user updates an article" do
    it "shows the updated article title" do
      visit "/articles/new"
      fill_in "article_title", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      fill_in "article_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Article"
      sleep(1)
      expect(page).to have_current_path(article_path(Article.last))
      click_link "Edit"
      fill_in "article_title", with: "Updated Title"
      click_button "Update Article"
      sleep(1)
      expect(page).to have_content("Updated Title")
    end
  end
end
