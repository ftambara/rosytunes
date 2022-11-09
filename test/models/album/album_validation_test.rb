require "test_helper"

class AlbumValidationTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @album = albums(:one).dup
  end

  test "MBID cannot be empty" do
    attribute_not_empty_test(@album, :mbid)
  end

  test "MBID must be unique" do
    album = albums(:two)
    album.mbid = @album.mbid
    assert_not album.valid?
  end

  test "name cannot be empty" do
    attribute_not_empty_test(@album, :name)
  end
end
