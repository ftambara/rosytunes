require "test_helper"

class SongValidationTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @song = songs(:november_rain)
  end

  test "an song can be valid" do
    @song.valid?
    assert_empty @song.errors.full_messages
  end

  test "API ID must be present" do
    @song.api_id = nil
    @song.valid?
    assert_not_empty @song.errors.full_messages
  end

  test "API ID must be unique" do
    duplicated_song = Song.new(api_id: @song.api_id)
    duplicated_song.valid?
    assert_not_empty duplicated_song.errors.full_messages
  end
end
