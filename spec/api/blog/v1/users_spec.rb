# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Blog::V1::Users, type: :request do
  let!(:user) { create(:user) }

  # Fetch / list all posts made by one user
  describe "GET /users/:user_id/articles" do
    context "when user id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user doesn't exist" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
