require "test_helper"

class ArtistAttributesTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @artist = VCR.use_cassette("artist:find:guns_n_roses") do
      artists(:guns_n_roses)
    end
  end

  test "name is filled for a found record" do
    VCR.use_cassette("artist:find:guns_n_roses") do
      attribute_not_nil_test(@artist, :name)
    end
  end

  test "albums are filled for a found record" do
    VCR.use_cassette("artist:find:guns_n_roses:inc_albums") do
      attribute_not_empty_test(@artist, :albums)
    end
  end
end
