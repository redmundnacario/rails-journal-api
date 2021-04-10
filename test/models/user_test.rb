require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Check presence of variables

  test "Check Presence" do
    user = User.new(
      username: "", password: "", email: ""
    )

    assert_not user.save, "Saved the user with empty variables"
  end

  # Check uniqueness of email
  test "Check Uniqueness of email/accounts" do
    user1 = User.new(
      username: "red", password: "Applepen123", email: "red@gmail.com"
    )
    user1.save

    user2 = User.new(
      username: "redi", password: "Applepen123", email: "red@gmail.com"
    )

    assert_not user2.save, "Saved the user2 with duplicate email account"
  end

  # check length of password
  # test "Check length of password" do
  #   user1 = User.new(
  #     username: "red", password: "123", email: "red@gmail.com"
  #   )

  #   assert_not user1.save, "Saved the user1 with password length less than 6 characters. Error: #{user1.save!}"
  # end


  # check alpha numeric password
end
