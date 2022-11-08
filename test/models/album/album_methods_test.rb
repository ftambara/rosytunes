require "test_helper"

class AlbumMethodsTest < ActiveSupport::TestCase
  test "it knows its MB adapter" do
    assert_equal MbAdapter, Album.mb_adapter.superclass
  end
end
