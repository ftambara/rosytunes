require "test_helper"

class ArtistValidationTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @artist = VCR.use_cassette("artist:find:guns_n_roses") do
      artists(:guns_n_roses)
    end
  end

  test "an artist can be valid" do
    @artist.valid?
    assert_empty @artist.errors.full_messages
  end

  test "API ID must be present" do
    @artist.api_id = nil
    @artist.valid?
    assert_not_empty @artist.errors.full_messages
  end

  test "API ID must be unique" do
    duplicated_artist = Artist.new(api_id: @artist.api_id)
    duplicated_artist.valid?
    assert_not_empty duplicated_artist.errors.full_messages
  end
end
