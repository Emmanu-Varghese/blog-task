# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::Blog::V1::Articles, type: :request do

  # Fetch / display a single post
  describe "GET /:article_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when everthing good" do
    end
  end

  #Create article
  describe "POST /articles" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when title is nil" do
    end

    context "when body is nil" do
    end

    context "when user is nil" do
    end

    context "when everthing good" do
    end
  end

  #Update article
  describe "PATCH /:article_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when title is nil" do
    end

    context "when body is nil" do
    end

    context "when everthing good" do
    end
  end

  #Delete article
  describe "DELETE /:article_id" do
    context "when article id is nil" do
    end

    context "when article doesn't exist" do
    end

    context "when everthing good" do
    end
  end
end
