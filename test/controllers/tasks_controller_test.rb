require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = User.new(
      username: "redmund", password: "Applepen123", email: "red@gmail.com"
    ).save
  
    @user_id = User.find_by(email: "red@gmail.com").id
    # @journal = journals(:one)
    journal = {
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    }

    # login
    post login_url, params: { password: "Applepen123", email: "red@gmail.com" }, as: :json
    @token = eval(@response.body)[:token]

    

    # create journal
    post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: journal, as: :json
    @journal_id = eval(@response.body)[:data][:id]
    @journal = eval(@response.body)[:data]
    # puts @journal_id
    # puts @response.status

    # puts Journal.all[2][:id]

    @task = {
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      deadline: Date.today.iso8601 , 
      done: true,
      journal_id: @journal_id
    }

    @task_new = {
      title: Faker::Book.title,
      description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      deadline: Date.today.iso8601 , 
      done: false,
      journal_id: @journal_id
    }
  end



  test "should get index" do
    get tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    assert_response :success
  end

  # Test get_tasks_by_journal_id 
  test "should get tasks by journal id" do
    get get_tasks_by_journal_id_url(@journal), headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    assert_response :success
  end

  # Test get_tasks_today
  test "should get tasks today" do
    post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json

    get get_tasks_today_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    
    assert_response :success
  end

  test "should create task" do
    assert_difference('Task.count') do
      post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json
    end

    assert_response 201
  end


  test "should show task" do
    post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json
    task = eval(@response.body)[:data]

    get task_url(task), headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    assert_response :success
  end


  test "should update task" do

    post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json
    task = eval(@response.body)[:data]
    
    patch task_url(task), headers: { "Authorization" => "Bearer #{@token}" }, params: @task_new, as: :json
    assert_response 200
  end


  test "should destroy task" do
    post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json
    task = eval(@response.body)[:data]

    assert_difference('Task.count', -1) do
      delete task_url(task), headers: { "Authorization" => "Bearer #{@token}" }, params: @task, as: :json
    end

    assert_response :success
  end
end
