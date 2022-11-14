require "test_helper"

class ArtistTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @artist = artists(:one)
  end

  test "API ID cannot be empty" do
    attribute_not_empty_test(@artist, :api_id)
  end

  test "API ID must be unique" do
    artist = artists(:two)
    artist.api_id = @artist.api_id
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

  test "it knows its API mapper" do
    assert_equal ApiMapper::Base, Artist.api_mapper.superclass
  end

  test "it delegates search to gateway" do
    query = "Guns N' Roses"

    gateway = Minitest::Mock.new
    gateway.expect(:list_of, true) do |klass, string|
      [Artist, query] == [klass, string]
    end
    MusicLibraryGateway.stub :new, gateway do
      Artist.search(query)
    end

    assert_mock gateway
  end

  test "it persists searches" do
    initial_count = Artist.count
    collection = Artist.search("Guns N' Roses")
    assert_operator initial_count, :<, collection.size
  end
end
