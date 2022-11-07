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
end
