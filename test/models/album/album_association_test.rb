require "test_helper"

class AlbumAssociationTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @album = albums(:one)
  end

  test "an album can have an artist" do
    can_have_one_test(@album, :artists, artists(:one))
  end

  test "an album can multiple artists" do
    can_have_many_test(@album, :artists, [artists(:one), artists(:two)])
  end

  test "an album can have a song" do
    can_have_one_test(@album, :songs, songs(:one))
  end

  test "an album can have multiple songs" do
    can_have_many_test(@album, :songs, [songs(:one), songs(:two)])
  end
end
