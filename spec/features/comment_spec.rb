require "rails_helper"

RSpec.describe "Comments" do
  let!(:user) { create(:user, password: "test1234") }

  before do
    visit "/users/sign_in"
    within("#new_user") do
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
    end
    click_button "Log in"
    sleep(2)
    visit "/articles/new"
    fill_in "article_title", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
    fill_in "article_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
    click_button "Create Article"
    sleep(1)
  end

  context "when user creates a new comment with empty body" do
    it "nothing happens" do
      visit article_path(Article.last)
      click_button "Create Comment"
      sleep(1)
      expect(page).not_to have_css(".comment")
    end
  end

  context "when user creates a new comment with body" do
    it "shows new comment" do
      visit article_path(Article.last)
      fill_in "comment_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Comment"
      sleep(1)
      expect(page).to have_css(".comment")
    end
  end

  context "when user edits a comment" do
    it "shows updated comment" do
      visit article_path(Article.last)
      fill_in "comment_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Comment"
      sleep(1)
      expect(page).to have_css(".comment")
      first(".comment > small > span > a").click
      fill_in "edit-comment-text", with: "Updated comment"
      sleep(1)
      click_button "Update Comment"
      expect(page).to have_content("Updated comment")
    end
  end

  context "when user delete a comment" do
    it "delete the comment" do
      visit article_path(Article.last)
      find(:css, "#comment_body").click.set(Faker::Lorem.words(number: rand(2..5)).join(" "))
      click_button "Create Comment"
      sleep(1)
      expect(page).to have_css(".comment")
      first(".comment > small > span > a").click
      page.accept_confirm do
        click_link "Destroy"
      end
      sleep(1)
      expect(page).not_to have_css(".comment")
    end
  end

  context "when user click on an emoji for first time" do
    it "increases that emoji counter to 1" do
      visit article_path(Article.last)
      fill_in "comment_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Comment"
      sleep(1)
      expect(page).to have_css(".comment")
      first(".emojis > a").click
      expect(page).to have_selector("span", text: "1")
    end
  end

  context "when user click on an emoji two times" do
    it "increases that emoji counter to 1 first then it becomes 0" do
      visit article_path(Article.last)
      fill_in "comment_body", with: Faker::Lorem.words(number: rand(2..5)).join(" ")
      click_button "Create Comment"
      sleep(1)
      first(".emojis > a").click
      expect(page).to have_selector("span", text: "1")
      first(".emojis > a").click
      expect(page).not_to have_selector("span", text: "1")
    end
  end
end
