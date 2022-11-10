require "test_helper"

class AlbumMethodsTest < ActiveSupport::TestCase
  test "it knows its MB adapter" do
    assert_equal MbAdapter, Album.mb_adapter.superclass
  end

  test "it delegates search to gateway" do
    model = Album
    query = "Appetite For Destruction"

    gateway = Minitest::Mock.new
    gateway.expect(:list_of, true) do |adapter, matching:|
      assert_equal [adapter, matching], [model.mb_adapter, query]
      true
    end
    MusicLibraryGateway.stub :new, gateway do
      Album.search(query)
    end

    assert_mock gateway
  end

  test "it persists searches" do
    initial_count = Album.count
    collection = Album.search("Appetite For Destruction")
    assert_operator initial_count, :<, collection.size
  end
end
