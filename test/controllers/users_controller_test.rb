require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as(users(:one)) }

  test "should get mypage" do
    get mypage_url
    assert_response :success
  end

  test "should get show" do
    get user_url(users(:one))
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url(users(:one))
    assert_response :success
  end

  test "should update user" do
    patch user_url(users(:one)), params: { user: { name: "Updated Name" } }
    assert_redirected_to mypage_url
  end

  test "should destroy user" do
    delete user_url(users(:one))
    assert_redirected_to root_url
  end
end
