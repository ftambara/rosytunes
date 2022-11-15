require "test_helper"

class MenuPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :ok
  end
end
