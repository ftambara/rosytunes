require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @artist = artists(:guns_n_roses)
  end

  test "it knows its related artists" do
    assert_difference("@user.artists.count", 1) do
      @user.artists << @artist
    end
  end

  test "knows if artist is associated to it" do
    @user.artists << @artist
    assert @user.bookmarked_artist?(@artist)
  end

  test "knows if an artist isn't associated to it" do
    assert_not @user.bookmarked_artist?(@artist)
  end
end
