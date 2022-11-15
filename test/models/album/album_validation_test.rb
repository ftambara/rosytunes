require "test_helper"

class AlbumValidationTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @album = VCR.use_cassette("album:find:appetite_for_destruction") do
      albums(:appetite_for_destruction)
    end
  end

  test "an album can be valid" do
    @album.valid?
    assert_empty @album.errors.full_messages
  end

  test "API ID must be present" do
    @album.api_id = nil
    @album.valid?
    assert_not_empty @album.errors.full_messages
  end

  test "API ID must be unique" do
    duplicated_album = Album.new(api_id: @album.api_id)
    duplicated_album.valid?
    assert_not_empty duplicated_album.errors.full_messages
  end
end
