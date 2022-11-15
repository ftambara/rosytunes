require "test_helper"

class MusicLibraryGatewayTest < ActiveSupport::TestCase
  setup do
    @gateway = MusicLibraryGateway.new
  end

  test "it searches for an album" do
    albums = VCR.use_cassette("album:search:ride_the_lightning:not_shallow") do
      @gateway.list_of(Album, "Ride The Lightning", shallow: false)
    end
    assert_not albums.empty?

    attributes = [:api_id, :name, :artists, :songs]
    albums.each do |album|
      attributes_are_not_empty_test(album, attributes)
    end
  end

  test "it searches for an artist" do
    artists = VCR.use_cassette("artist:search:metallica") do
      @gateway.list_of(Artist, "Metallica")
    end
    assert_not artists.empty?

    attributes = [:api_id, :name]
    artists.each do |artist|
      attributes_are_not_empty_test(artist, attributes)
    end
  end

  test "search results are empty when query is blank" do
    albums_empty = @gateway.list_of(Artist, "")
    assert albums_empty.empty?

    albums_whitespace = @gateway.list_of(Album, " ")
    assert albums_whitespace.empty?
  end

  test "searching with an invalid model_class raises an error" do
    assert_raises do
      @gateway.list_of("", "query")
    end
  end

  test "it finds an album" do
    model = VCR.use_cassette("album:appetite_for_destruction") do
      @gateway.find(albums(:appetite_for_destruction))
    end
    assert_kind_of Album, model
  end

  test "it places a limit on API-call frequency" do
    skip
  end

  private
    def attributes_are_not_empty_test(model, attributes)
      attributes.each do |attribute|
        assert_not model.send(attribute).empty?
      end
    end
end
