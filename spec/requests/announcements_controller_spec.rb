require "rails_helper"

RSpec.describe AnnouncementsController, type: :controller do
  context "when an expection happens while viewing announcements" do
    before do
      allow(Rails.logger).to receive(:error)
      allow(Announcement).to receive(:order).and_raise(StandardError)
    end

    describe "GET index" do
      it "logs error in console" do
        visit announcements_path
        sleep(1)
        expect(Rails.logger).to have_received(:error).with(/Error happened while viewing announcements/)
      end
    end
  end

  context "when everything is good while viewing announcements" do
    before do
      allow(Rails.logger).to receive(:error)
    end

    describe "GET index" do
      it "no error seen in console" do
        visit announcements_path
        sleep(1)
        expect(Rails.logger).to have_received(:error).with(/Error happened while viewing announcements/)
          .exactly(0).times
      end
    end
  end
end
