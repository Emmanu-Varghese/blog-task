# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Blog::V1::Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article) }
  let!(:comment) { create(:comment) }
  let!(:comments) { create_list(:comment, 10, commentable: article) }
  

  let(:valid_attributes) {
    { body: "MyText", commentable_type: "Article", user_id: user.id }
  }

  let(:attributes_with_body_blank) {
    { body: nil, commentable_type: "Article", user_id: user.id }
  }

  let(:attributes_with_user_blank) {
    { body: "MyText", commentable_type: "Article", user_id: nil }
  }

  # Fetch / list all comments for a post together with the reactions on these comments
  describe "GET /:article_id/comments" do
    context "when article id is invalid" do
      it "returns http 422" do
        get "/api/blog/v1/articles/#{rand(100...400)}/comments", as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        get "/api/blog/v1/articles/#{article.id}/comments", as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # Create comment
  describe "POST /api/blog/v1/articles/:article_id/comments" do
    context "when article id is invalid" do
      it "returns http 422" do
        post "/api/blog/v1/articles/#{rand(100...400)}/comments", params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        post "/api/blog/v1/articles/#{article.id}/comments", params: { comment: attributes_with_body_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is nil" do
      it "returns http 422" do
        post "/api/blog/v1/articles/#{article.id}/comments", params: { comment: attributes_with_user_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        post "/api/blog/v1/articles/#{article.id}/comments", params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  # # Update comment
  describe "PATCH /:article_id/comments/:comment_id" do
    context "when article id is invalid" do
      it "returns http 422" do
        patch "/api/blog/v1/articles/#{rand(100...400)}/comments/#{comment.id}", params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when comment id is invalid" do
      it "returns http 422" do
        patch "/api/blog/v1/articles/#{article.id}/comments/#{rand(100...400)}", params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        patch "/api/blog/v1/articles/#{article.id}/comments/#{comment.id}", params: { comment: attributes_with_body_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        patch "/api/blog/v1/articles/#{article.id}/comments/#{comment.id}", params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # # Delete comment
  describe "DELETE /:article_id/comments/:comment_id" do
    context "when article id is invalid" do
      it "returns http 422" do
        delete "/api/blog/v1/articles/#{article.id}/comments/#{rand(100...400)}", as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        delete "/api/blog/v1/articles/#{article.id}/comments/#{comment.id}", as: :json
        expect(response).to have_http_status(:no_content)
      end
    end
  end
end
