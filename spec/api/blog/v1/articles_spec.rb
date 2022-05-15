# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Blog::V1::Articles, type: :request do
  # Fetch / display a single post
  describe "GET /:article_id" do
    context "when article id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when article doesn't exist" do
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

  # Create article
  describe "POST /articles" do
    context "when article id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when article doesn't exist" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when title is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is nil" do
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

  # Update article
  describe "PATCH /:article_id" do
    context "when article id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when article doesn't exist" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when title is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
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

  # Delete article
  describe "DELETE /:article_id" do
    context "when article id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when article doesn't exist" do
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
