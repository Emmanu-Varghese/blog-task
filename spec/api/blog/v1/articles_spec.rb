# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Blog::V1::Articles", type: :request do
  let!(:article) { create(:article) }
  let!(:user) { create(:user) }
  let(:valid_attributes) {
    { title: "MyString", body: "MyText", user_id: user.id }
  }

  let(:attributes_with_title_blank) {
    { title: "", body: "MyText", user_id: user.id }
  }

  let(:attributes_with_body_blank) {
    { title: "MyString", body: "", user_id: user.id }
  }

  let(:attributes_with_user_blank) {
    { title: "MyString", body: "MyText", user_id: nil }
  }

  # Fetch / display a single post
  describe "GET /api/blog/v1/articles/:article_id" do
    context "when article id is nil" do
      it "returns http 422" do
        get "/api/blog/v1/articles/#{nil}", as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when article doesn't exist" do
      it "returns http 404" do
        get "/api/blog/v1/articles/#{rand(10...40)}", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        get "/api/blog/v1/articles/#{article.id}", as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # Create article
  describe "POST /api/blog/v1/articles" do
    context "when title is nil" do
      it "returns http 422" do
        post "/api/blog/v1/articles", params: { article: attributes_with_title_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        post "/api/blog/v1/articles", params: { article: attributes_with_body_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is nil" do
      it "returns http 422" do
        post "/api/blog/v1/articles", params: { article: attributes_with_user_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        post "/api/blog/v1/articles", params: { article: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  # # Update article
  describe "PATCH /:article_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        patch "/api/blog/v1/articles/#{rand(10...40)}", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when title is nil" do
      it "returns http 422" do
        patch "/api/blog/v1/articles/#{article.id}", params: { article: attributes_with_title_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        patch "/api/blog/v1/articles/#{article.id}", params: { article: attributes_with_body_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        patch "/api/blog/v1/articles/#{article.id}", params: { article: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # # Delete article
  describe "DELETE /:article_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        delete "/api/blog/v1/articles/#{rand(10...40)}", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        delete "/api/blog/v1/articles/#{article.id}", as: :json
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
