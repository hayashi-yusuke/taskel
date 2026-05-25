require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as(users(:one)) }

  test "should get index" do
    get tasks_url
    assert_response :success
  end

  test "should get show" do
    get task_url(tasks(:one))
    assert_response :success
  end

  test "should get edit" do
    get edit_task_url(tasks(:one))
    assert_response :success
  end
end
