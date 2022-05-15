# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Blog::V1::Users", type: :request do
  let!(:user) { create(:user) }
  let!(:comments) { create_list(:comment, 10, user: user) }

  # Fetch / list all posts made by one user
  describe "GET /users/:user_id/articles" do
    context "when user id is invalid" do
      it "returns http 422" do
        get "/api/blog/v1/users/#{rand(100...400)}/articles", as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        get "/api/blog/v1/users/#{user.id}/articles", as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
