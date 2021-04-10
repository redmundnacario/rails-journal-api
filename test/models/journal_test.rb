require "test_helper"

class JournalTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    user = User.new(
      username: "redmund", password: "Applepen123", email: "red@gmail.com"
    ).save
  
    @user_id = User.find_by(email: "red@gmail.com").id
  end

  test "Check presence of title in journal" do
    journal = Journal.new(
      title: nil,
      description: "sample decription",
      user_id: @user_id
    )
    # Journal must not save. if save triggered error
    assert_not journal.save, "Saved the journal with empty journal"
  end


  test "Check presence of description in journal" do
    journal = Journal.new(
      title: "sample title",
      description: nil,
      user_id: @user_id
    )
    # Journal must not save. if save triggere error, if not
    assert_not journal.save, "Saved the journal with empty description"
  end


  test "Check saving an empty string" do
    journal = Journal.new(
      title: "",
      description: "",
      user_id: @user_id
    )
    # Journal must not save. if save triggere error, if not
    assert_not journal.save, "Saved the journal with empty description"
  end


  test "Check length of description in journal Part 1" do
    journal = Journal.new(
      title: "sample title",
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor inc",
      user_id: @user_id
    )

    assert journal.save, "The journal was saved with description < 50 length. Current length: #{journal.description.length}"
  end


  test "Check length of description in journal Part 2" do
    journal = Journal.new(
      title: "sample title",
      description: "Lorem",
      user_id: @user_id
    )

    assert_not journal.save, "The journal was saved with description < 50 length. Current length: #{journal.description.length}"
  end
end
