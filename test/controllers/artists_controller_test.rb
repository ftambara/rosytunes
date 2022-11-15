require "test_helper"

class ArtistControllerTest < ActionDispatch::IntegrationTest
  test "get index with query parameter" do
    VCR.use_cassette("artist:search:metallica:inc_albums") do
      get artists_path(query: "Metallica")
    end
    assert_response :success
  end

  test "get current user's artists" do
    skip
  end

  test "show artist" do
    VCR.use_cassette("artist:find:guns_n_roses") do
      get artist_path(artists(:guns_n_roses))
    end
    assert_response :success
  end
end
