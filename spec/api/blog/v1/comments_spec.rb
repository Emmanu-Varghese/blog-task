# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::Blog::V1::Comments", type: :request do
  let!(:user) { create(:user) }
  let!(:article) { create(:article, user: user) }
  let!(:comment) { create(:comment, article: article) }

  let(:valid_attributes) {
    { body: "MyText", article_id: article.id, user_id: user.id }
  }

  let(:attributes_with_body_blank) {
    { body: nil, article_id: article.id, user_id: user.id }
  }

  let(:attributes_with_user_blank) {
    { body: "MyText", article_id: article.id, user_id: nil }
  }

  # Fetch / list all comments for a post together with the reactions on these comments
  describe "GET /api/blog/v1/users/:user_id/articles/:article_id/comments" do
    context "when user id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{rand(100...400)}/articles/#{article.id}/comments", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when article id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{rand(100...400)}/comments", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        get "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments", as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # Create comment
  describe "POST /api/blog/v1/users/:user_id/articles/:article_id/comments" do
    context "when article id is invalid" do
      it "returns http 404" do
        post "/api/blog/v1/users/#{user.id}/articles/#{rand(100...400)}/comments",
             params: { comment: valid_attributes }, as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        post "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments",
             params: { comment: attributes_with_body_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when user is nil" do
      it "returns http 422" do
        post "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments",
             params: { comment: attributes_with_user_blank }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        post "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments", params: { comment: valid_attributes },
                                                                              as: :json
        expect(response).to have_http_status(:created)
      end
    end
  end

  # # Update comment
  describe "PATCH /api/blog/v1/users/:user_id/articles/:article_id/comments/:comment_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        patch "/api/blog/v1/users/#{user.id}/articles/#{rand(100...400)}/comments/#{comment.id}",
              params: { comment: valid_attributes },
              as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when comment id is invalid" do
      it "returns http 404" do
        patch "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{rand(100...400)}",
              params: { comment: valid_attributes },
              as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when body is nil" do
      it "returns http 422" do
        patch "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{comment.id}",
              params: { comment: attributes_with_body_blank },
              as: :json
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when everthing good" do
      it "returns http 200" do
        patch "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{comment.id}",
              params: { comment: valid_attributes },
              as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  # # Delete comment
  describe "DELETE /api/blog/v1/users/:user_id/articles/:article_id/comments/:comment_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        delete "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{rand(100...400)}", as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when everthing good" do
      it "returns http 201" do
        delete "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{comment.id}", as: :json
        expect(response).to have_http_status(:no_content)
      end
    end
  end

  # Comment add reactions
  describe "GET /api/blog/v1/users/:user_id/articles/:article_id/comments/:id/add-emote?"\
           "emote=:emoji&user_id=:user_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{rand(100...400)}/comments/#{comment.id}/add-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when comment id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{rand(100...400)}/add-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{comment.article.id}/comments/#{comment.id}/add-emote?"\
            "emote=like&reacting_user_id=#{rand(100...400)}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user reacts to a comment" do
      it "returns http 200" do
        get "/api/blog/v1/users/#{user.id}/articles/#{comment.article.id}/comments/#{comment.id}/add-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /api/blog/v1/users/:user_id/articles/:article_id/comments/:id/remove-emote?"\
           "emote=:emoji&user_id=:user_id" do
    context "when article id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{rand(100...400)}/comments/#{comment.id}/remove-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when comment id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{article.id}/comments/#{rand(100...400)}/remove-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user id is invalid" do
      it "returns http 404" do
        get "/api/blog/v1/users/#{user.id}/articles/#{comment.article.id}/comments/#{comment.id}/remove-emote?"\
            "emote=like&reacting_user_id=#{rand(100...400)}",
            as: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user reacts to a comment" do
      it "returns http 200" do
        get "/api/blog/v1/users/#{user.id}/articles/#{comment.article.id}/comments/#{comment.id}/remove-emote?"\
            "emote=like&reacting_user_id=#{user.id}",
            as: :json
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
