require "test_helper"

class FollowerControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get follower_new_url
    assert_response :success
  end

  test "should get create" do
    get follower_create_url
    assert_response :success
  end
end
