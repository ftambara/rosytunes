require "test_helper"

class MusicLibraryGatewayTest < ActiveSupport::TestCase
  # TODO make this tests run only when explicitly told,
  # since they interact with an external API
  setup do
    @gateway = MusicLibraryGateway.new
  end

  test "it searches for an album" do
    albums = VCR.use_cassette("album:search:ride_the_lightning") do
      @gateway.list_of(Album, "Ride The Lightning")
    end
    assert_not albums.empty?

    attributes = [:api_id, :name, :artists]
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
    albums_empty = VCR.use_cassette("artist:search:empty") do
      @gateway.list_of Artist, ""
    end

    albums_whitespace = VCR.use_cassette("artist:search:whitespace") do
      @gateway.list_of(Album, " ")
    end

    assert albums_empty.empty?
    assert albums_whitespace.empty?
  end

  test "searching with an invalid model_class raises an error" do
    assert_raises do
      VCR.use_cassette("empty:search:query") do
        @gateway.list_of "", "query"
      end
    end
  end

  test "it finds an album" do
    model = VCR.use_cassette("album:appetite_for_destruction") do
      @gateway.find(albums(:appetite_for_destruction))
    end
    assert_kind_of Album, model
  end

  test "it fails to get details for an unknown model" do
    skip
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
