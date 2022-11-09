require "test_helper"

class MusicLibraryGatewayTest < ActiveSupport::TestCase
  # TODO make this tests run only when explicitly told,
  # since they interact with an external API
  include WithVCR

  setup do
    @gateway = MusicLibraryGateway.new
  end

  test "it searches for an album" do
    collection = with_expiring_vcr_cassette(name: "album_search") do
      @gateway.list_of Album.mb_adapter, matching: "Appetite For Destruction"
    end
    assert_not collection.empty?

    attributes = [:mbid, :name, :artists]
    collection.each do |album|
      attributes_are_not_empty_test(album, attributes)
    end
  end

  test "it searches for an artist" do
    collection = with_expiring_vcr_cassette(name: "artist_search") do
      @gateway.list_of Artist.mb_adapter, matching: "Guns N' Roses"
    end
    assert_not collection.empty?

    attributes = [:mbid, :name]
    collection.each do |album|
      attributes_are_not_empty_test(album, attributes)
    end
  end

  test "search results are empty when query is blank" do
    collection = @gateway.list_of Artist.mb_adapter, matching: ""
    assert collection.empty?

    collection = @gateway.list_of Artist.mb_adapter, matching: " "
    assert collection.empty?
  end

  test "searching with an invalid model_class raises an error" do
    assert_raises do
      collection = @gateway.list_of "", matching: "query"
    end
  end

  test "it gets details for the given model" do
  end

  test "it fails to get details for an unknown model" do
  end

  test "it places a limit on API-call frequency" do
  end

  private
    def attributes_are_not_empty_test(model, attributes)
      attributes.each do |attribute|
        assert_not model.send(attribute).empty?
      end
    end
end
