require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get albums_path
    assert_response :success
  end

  test "should get index with query param" do
    get albums_path(query: "Appetite For Destruction")
    assert_response :success
  end

  test "should show album details" do
    get album_path(albums(:one))
    assert_response :success
  end
end
