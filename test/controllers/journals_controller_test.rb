require "test_helper"

class JournalsControllerTest < ActionDispatch::IntegrationTest
# class JournalsControllerTest < ActionController::TestCase
  setup do
    user = User.new(
      username: "redmund", password: "Applepen123", email: "red@gmail.com"
    ).save
  
    @user_id = User.find_by(email: "red@gmail.com").id

    # @journal = journals(:one)
    @journal = {
      
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
    }
    @journal_new = {
     
      title: Faker::Book.title,
      description: "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
    }

    post login_url, params: { password: "Applepen123", email: "red@gmail.com" }, as: :json
    @token = eval(@response.body)[:token]

  end

  test "should get index" do
    # @request.env["Authorization"] = "Bearer red"
    get journals_url, headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    assert_response :success
  end

  test "should create journal" do
    assert_difference('Journal.count') do
      post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @journal, as: :json
      # journal = eval(@response.body)[:data]
      # puts journal
    end
    
    assert_response 201
  end

  test "should show journal" do
    post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @journal, as: :json
    journal = eval(@response.body)[:data]
    assert_response 201

    get journal_url(journal), headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    assert_response :success
  end

  test "should update journal" do
    post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @journal, as: :json
    journal = eval(@response.body)[:data]
    assert_response 201
    
    patch journal_url(journal), headers: { "Authorization" => "Bearer #{@token}" }, params: @journal_new , as: :json
    assert_response 200
  end

  test "should destroy journal" do
    post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @journal, as: :json
    journal = eval(@response.body)[:data]
    assert_response 201

    # puts eval(@response.body)[:data][:id]

    assert_difference('Journal.count', -1) do
      delete journal_url(journal),headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    end

    assert_response :success
  end

  test "should destroy journal also cascade to tasks" do
    post journals_url, headers: { "Authorization" => "Bearer #{@token}" }, params: @journal, as: :json
    journal = eval(@response.body)[:data]
    assert_response 201

    journal_id = eval(@response.body)[:data][:id]

    task = {
      title: Faker::Book.title,
      description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
      deadline: Date.today.iso8601 , 
      done: true,
      journal_id: journal_id
    }
    # Create task
    post tasks_url, headers: { "Authorization" => "Bearer #{@token}" }, params: task, as: :json
    task_id = eval(@response.body)[:data][:id]

    assert_difference('Journal.count', -1) do
      delete journal_url(journal),headers: { "Authorization" => "Bearer #{@token}" }, as: :json
    end

    assert_response :success

    task_out = Task.where(id: task_id)
    assert_equal 0, task_out.length

  end
end
 