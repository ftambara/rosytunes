require "test_helper"

class SongTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @song = songs(:one)
  end

  test "MBID cannot be empty" do
    attribute_not_empty_test(@song, :mbid)
  end

  test "MBID must be unique" do
    song = songs(:two)
    song.mbid = @song.mbid
    assert_not song.valid?
  end

  test "name cannot be empty" do
    attribute_not_empty_test(@song, :name)
  end

  test "a song can belong to an album" do
    can_have_one_test(@song, :albums, albums(:one))
  end

  test "a song can appear on multiple albums" do
    can_have_many_test(@song, :albums, [albums(:one), albums(:two)])
  end

  test "a song can feature a single artist" do
    can_have_one_test(@song, :artists, artists(:one))
  end

  test "a song can feature multiple artists" do
    can_have_many_test(@song, :artists, [artists(:one), artists(:two)])
  end

  test "it knows its MB adapter" do
    assert_equal MbAdapter, Song.mb_adapter.superclass
  end
end
