require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  # test Signup or register
  setup do
    User.new(
      username: "redmund", password: "Applepen123", email: "red@gmail.com"
    ).save!

  end
 

  test "Check sign up with duplicate user account" do
    post users_url, params: { username: "redmund", email:"red@gmail.com", password: "Applepen123" }, as: :json
    assert_response 422
  end


  test "Check sign up with new account" do
    post users_url, params: { username: "redmund", email:"marge@gmail.com", password: "Applepen123" }, as: :json
    assert_response :success
  end


  test "Check login with no existing account" do
    post login_url, params: { email:"redi@gmail.com", password: "Applepen123" }, as: :json
    assert_response 422
  end


  test "Check login with existing account" do
    post login_url, params: { email:"red@gmail.com", password: "Applepen123" }, as: :json
    assert_response :success
  end


  test "Check auto login" do
    post login_url, params: { email:"red@gmail.com", password: "Applepen123" }, as: :json
    token = eval(@response.body)[:token]

    get auto_login_url, headers: { "Authorization" => "Bearer #{token}" }, as: :json
    assert_response :success
  end

  # test edit user
  test "should update user" do
    post users_url, params: { username: "redmund", email:"redi@gmail.com", password: "Applepen123" }, as: :json
    token = eval(@response.body)[:token]

    user_new = {
      # username: "redmundo"
      password: "eafaetea"
    }
    
    patch user_url, headers: { "Authorization" => "Bearer #{token}" }, params: user_new , as: :json
    assert_response 200
  end


  test "delete user" do
    post users_url, params: { username: "redmund", email:"redi@gmail.com", password: "Applepen123" }, as: :json
    token = eval(@response.body)[:token]

    delete user_url, headers: { "Authorization" => "Bearer #{token}" }, as: :json
    assert_response :success
  end

  test "delete user cascade to journals and tasks" do 
    # Create user
    post users_url, params: { username: "redmund", email:"redi@gmail.com", password: "Applepen123" }, as: :json
    token = eval(@response.body)[:token]

    journal = {
      
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    }
    # Create journal
    post journals_url, headers: { "Authorization" => "Bearer #{token}" }, params: journal, as: :json
    journal_id = eval(@response.body)[:data][:id]

    task = {
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      deadline: Date.today.iso8601 , 
      done: true,
      journal_id: journal_id
    }
    # Create task
    post tasks_url, headers: { "Authorization" => "Bearer #{token}" }, params: task, as: :json
    task_id = eval(@response.body)[:data][:id]

    # delete user
    delete user_url, headers: { "Authorization" => "Bearer #{token}" }, as: :json
    assert_response :success

    # find journal
    journal_out = Journal.where(id: journal_id)
    assert_equal 0, journal_out.length
    # find task
    task_out = Task.where(id: task_id)
    assert_equal 0, task_out.length
  end
end
