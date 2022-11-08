require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @artist = artists(:one)
  end

  test "MBID cannot be empty" do
    attribute_not_empty_test(@artist, :mbid)
  end

  test "MBID must be unique" do
    artist = artists(:two)
    artist.mbid = @artist.mbid
    assert_not artist.valid?
  end

  test "name cannot be empty" do
    attribute_not_empty_test(@artist, :name)
  end

  test "an artist can have an album" do
    can_have_one_test(@artist, :albums, albums(:one))
  end

  test "an artist can multiple albums" do
    can_have_many_test(@artist, :albums, [albums(:one), albums(:two)])
  end

  test "it knows its MB adapter" do
    assert_equal MbAdapter, Artist.mb_adapter.superclass
  end
end
