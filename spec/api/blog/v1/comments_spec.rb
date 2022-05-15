# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Blog::V1::Comments", type: :request do
  let!(:comment) { create(:comment) }
  let!(:user) { create(:user) }
  
  let(:valid_attributes) {
    { body: "MyText", commentable_type: "Article", commentable_id: 25, user_id: user.id }
  }

  let(:attributes_with_body_blank) {
    { body: nil, commentable_type: "Article", commentable_id: 25, user_id: user.id }
  }

  let(:attributes_with_user_blank) {
    { body: "MyText", commentable_type: "Article", commentable_id: 25, user_id: nil }
  }

  # Fetch / list all comments for a post together with the reactions on these comments
  describe "GET /:article_id/comments/:comment_id" do
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

    context "when comment id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when comment doesn't exist" do
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

  # Create comment
  describe "POST /:article_id/comments" do
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

  # Update comment
  describe "PATCH /:article_id/comments/:comment_id" do
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

    context "when comment id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when comment doesn't exist" do
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

  # Delete comment
  describe "DELETE /:article_id/comments/:comment_id" do
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

    context "when comment id is nil" do
      it "returns http 422" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when comment doesn't exist" do
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
