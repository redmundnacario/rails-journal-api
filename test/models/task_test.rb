require "test_helper"

class TaskTest < ActiveSupport::TestCase

  # Setup
  
  setup do
    user = User.new(
      username: "redmund", password: "Applepen123", email: "red@gmail.com"
    ).save
  
    @user_id = User.find_by(email: "red@gmail.com").id

    journal = Journal.new(
      title: "sample title",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor inc",
      user_id: @user_id
    ).save

    @journal_id = Journal.first.id
  end

  # presence

  test "Check presence of variables" do
    task = Task.new(
      title: "",
      description: "",
      deadline: "",
      done: nil,
      journal_id: @journal_id ,
      user_id: @user_id
    )
    assert_not task.save, "Task saved with empty or missing variables."
  end

  # length

  test "Check length of description" do
    task = Task.new(
      title: "Task title",
      description: "Lorem ",
      deadline: "2022-04-09",
      done: false,
      journal_id: @journal_id ,
      user_id: @user_id
      )
    assert_not task.save, "Task saved with description length < 10"
  end
end
