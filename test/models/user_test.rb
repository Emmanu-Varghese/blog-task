require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "invalid without name" do
    user = User.new(email: "john@example.com", password: "qwerty")
    assert_not user.valid?, "user is valid without a name"
    assert_not_nil user.errors[:name], "no validation error for name present"
  end

  test "invalid without email" do
    user = User.new(name: "John", password: "qwerty")
    assert_not user.valid?
    assert_not_nil user.errors[:email]
  end

  test "valid user" do
    user = User.new(name: "John", email: "john@example.com", password: "qwerty")
    assert user.valid?
  end

  test "has first name" do
    assert_equal "Chris", users(:regular).first_name
  end

  test "can update first name" do
    users(:regular).update(first_name: "Regular")
    assert_equal "Regular", users(:regular).first_name
  end
end
