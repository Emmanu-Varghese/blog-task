# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Blog::V1::Comments, type: :request do
  # Fetch / list all comments for a post together with the reactions on these comments
  describe "GET /:article_id/comments/:comment_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when comment id is nil" do
    end

    context "when comment doesn't exist" do
    end

    context "when everthing good" do
    end
  end

  # Create comment
  describe "POST /:article_id/comments" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when body is nil" do
    end

    context "when user is nil" do
    end

    context "when everthing good" do
    end
  end

  # Update comment
  describe "PATCH /:article_id/comments/:comment_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when comment id is nil" do
    end

    context "when comment doesn't exist" do
    end

    context "when body is nil" do
    end

    context "when everthing good" do
    end
  end

  # Delete comment
  describe "PATCH /:article_id/comments/:comment_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when comment id is nil" do
    end

    context "when comment doesn't exist" do
    end

    context "when everthing good" do
    end
  end
end
