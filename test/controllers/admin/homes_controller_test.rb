require "test_helper"

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  setup { sign_in_as_admin(admins(:one)) }

  test "should get top" do
    get admin_top_url
    assert_response :success
  end
end
