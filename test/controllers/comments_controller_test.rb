require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as(users(:one)) }

  test "should create comment" do
    post task_comments_url(tasks(:one)), params: { comment: { content: "Test comment" } }
    assert_redirected_to task_url(tasks(:one))
  end

  test "should destroy comment" do
    delete task_comment_url(tasks(:one), comments(:one))
    assert_redirected_to task_url(tasks(:one))
  end
end
