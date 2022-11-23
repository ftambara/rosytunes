require "test_helper"

class ArtistControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @artist = artists(:guns_n_roses)
  end

  test "can create an bookmark for the current user" do
    sign_in(@user)
    params = { artist_bookmark: { artist_id: @artist.id } }
    assert_difference("ArtistBookmark.count", 1) do
      post user_artist_bookmarks_path(user_id: @user.id), params:
    end
    assert_response :redirect
  end

  test "cannot create a bookmark as a guest" do
    params = { artist_bookmark: { artist_id: @artist.id } }
    assert_no_difference("ArtistBookmark.count") do
      post user_artist_bookmarks_path(user_id: @user.id), params:
    end
    assert_response :redirect
  end

  test "cannot create a bookmark for another user" do
    sign_in(users(:two))
    params = { artist_bookmark: { artist_id: @artist.id } }
    assert_no_difference("ArtistBookmark.count") do
      post user_artist_bookmarks_path(user_id: @user.id), params:
    end
    assert_response :redirect
  end

  test "can delete a bookmark for the current user" do
  end

  test "cannot delete a bookmark as a guest" do
  end

  test "cannot delete a bookmark for another user" do
  end
end
