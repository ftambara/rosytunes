require "test_helper"

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  test "get index with query parameter" do
    VCR.use_cassette("album:search:appetite_for_destruction") do
      get albums_path(query: "Appetite For Destruction")
    end
    assert_response :success
  end

  test "get current user's albums" do
    skip
  end

  test "show album" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      get album_path(albums(:appetite_for_destruction))
    end
    assert_response :success
  end
end
