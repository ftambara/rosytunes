require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
  end

  test "gets a user's profile page if signed in" do
    sign_in(@user)
    get user_path(@user)
    assert_response :success
  end

  test "a user's profile is not accessible as a guest" do
    get user_path(users(:one))
    assert_redirected_to new_user_session_path
  end

  test "a user's profile is not accessible as another user" do
    sign_in(users(:two))
    get user_path(users(:one))
    assert_redirected_to root_path
  end
end
