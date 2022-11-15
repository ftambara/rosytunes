require "test_helper"

class ArtistMethodsTest < ActiveSupport::TestCase

  test "it knows its API mapper" do
    assert_equal ApiMapper::Base, Artist.api_mapper.superclass
  end

  test "it delegates search to gateway" do
    query = "Appetite For Destruction"

    gateway = Minitest::Mock.new
    gateway.expect(:list_of, true) do |klass, string|
      [Artist, query] == [klass, string]
    end
    MusicLibraryGateway.stub :new, gateway do
      Artist.search(query, persist: false)
    end

    assert_mock gateway
  end

  test "it persists searches by default" do
    initial_count = Artist.count
    collection = VCR.use_cassette("artist:search:metallica") do
      Artist.search("Metallica")
    end
    assert_operator initial_count, :<, collection.size
  end
end
