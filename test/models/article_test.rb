require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  setup do
    @user = users(:regular)
  end

  test "invalid without user" do
    article = Article.new(title: "Test article",
                          body: "It is a long established fact that a reader will be..")
    assert_not article.valid?, "article is valid without a user"
    assert_not_nil article.errors[:user_id], "no validation error for user_id present"
  end

  test "invalid without title" do
    article = Article.new(user_id: @user.id,
                          body: "It is a long established fact that a reader will be..")
    assert_not article.valid?, "article is valid without a title"
    assert_not_nil article.errors[:title], "no validation error for title present"
  end

  test "invalid without body" do
    article = Article.new(title: "Test article", user_id: @user.id)
    assert_not article.valid?, "article is valid without a body"
    assert_not_nil article.errors[:user_id], "no validation error for body present"
  end

  test "valid article" do
    article = Article.new(title: "Test article",
                          body: "It is a long established fact that a reader will be..", user_id: @user.id)
    assert article.valid?
  end

  test "can update title" do
    articles(:one).update(title: "Test article")
    assert_equal "Test article", articles(:one).title
  end
end
