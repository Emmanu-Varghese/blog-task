# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Blog::V1::Users, type: :request do
  # Fetch / list all posts made by one user
  describe "GET /users/:user_id/articles" do
    context "when user id is nil" do
    end

    context "when user doesn't exist" do
    end

    context "when everthing good" do
    end
  end
  
end
