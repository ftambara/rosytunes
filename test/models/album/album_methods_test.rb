require "test_helper"

class AlbumMethodsTest < ActiveSupport::TestCase
  test "it knows its API mapper" do
    assert_equal ApiMapper::Base, Album.api_mapper.superclass
  end

  test "it delegates search to gateway" do
    query = "Appetite For Destruction"

    gateway = Minitest::Mock.new
    gateway.expect(:list_of, true) do |klass, string|
      [Album, query] == [klass, string]
    end
    MusicLibraryGateway.stub :new, gateway do
      Album.search(query, persist: false)
    end

    assert_mock gateway
  end

  test "it persists searches by default" do
    initial_count = Album.count
    collection = VCR.use_cassette("album:search:between_the_buttons") do
      Album.search("Between The Buttons")
    end
    assert_operator initial_count, :<, collection.size
  end
end
