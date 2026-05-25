require "test_helper"

class LikesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as(users(:one)) }

  test "should create like" do
    post task_like_url(tasks(:two))
    assert_redirected_to root_url
  end

  test "should destroy like" do
    delete task_like_url(tasks(:one))
    assert_redirected_to root_url
  end
end
