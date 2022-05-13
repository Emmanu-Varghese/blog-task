require "rails_helper"

RSpec.describe "Announcement view" do
  context "when there is no announcements" do
    it "User who is not logged in should not see red dot" do
      visit "/"
      expect(page).not_to have_css(".unread-announcements")
    end

    it "User who logged in should not see red dot" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: ""
        fill_in "user_password", with: ""
      end
      click_button "Log in"
      expect(page).not_to have_css(".unread-announcements")
    end

    it "announcements list is empty" do
      visit "/announcements"
      expect(page).not_to have_css(".announcement")
    end

    it "Load more announcements button is not visible in announcements page" do
      visit "/announcements"
      expect(page).not_to have_content("Load previous announcements")
    end
  end

  context "when there is announcements" do
    let(:user) { create(:user) }
    let!(:announcements) { create_list(:announcement, 50) }

    it "User who is not logged in should see red dot" do
      visit "/"
      expect(page).to have_css(".unread-announcements")
    end

    it "User who logged in should see red dot" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      expect(page).to have_css(".unread-announcements")
    end

    it "announcements list is not empty" do
      visit "/announcements"
      expect(page).to have_content announcements.last.name
    end

    it "announcements list has 10 items" do
      visit "/announcements"
      expect(page).to have_selector(".announcement", count: 10)
    end

    it "Load previous announcements button is visible in announcements page" do
      visit "/announcements"
      expect(page).to have_content("Load previous announcements")
    end

    it "Clicking Load previous announcement button loads 10 previous announcements" do
      visit "/announcements"
      click_link "Load previous announcements"
      expect(page).to have_selector(".announcement", count: 20)
    end

    it "No red dots is shown to user who already visited announcement" do
      visit "/users/sign_in"
      within("#new_user") do
        fill_in "user_email", with: user.email
        fill_in "user_password", with: user.password
      end
      click_button "Log in"
      sleep(1)
      visit "/announcements"
      sleep(1)
      expect(page).not_to have_css(".unread-announcements")
    end
  end
end
