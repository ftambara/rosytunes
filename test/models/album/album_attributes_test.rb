require "test_helper"

class AlbumAttributesTest < ActiveSupport::TestCase
  include CommonTests::Model

  setup do
    @album = VCR.use_cassette("album:find:appetite_for_destruction") do
      albums(:appetite_for_destruction)
    end
  end

  test "name is filled for a found record" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      attribute_not_nil_test(@album, :name)
    end
  end

  test "release_date is filled for a found record" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      attribute_not_nil_test(@album, :release_date)
    end
  end

  test "release_type is filled for a found record" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      attribute_not_nil_test(@album, :release_type)
    end
  end

  test "artists are filled for a found record" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      attribute_not_empty_test(@album, :artists)
    end
  end

  test "songs are filled for a found record" do
    VCR.use_cassette("album:find:appetite_for_destruction") do
      attribute_not_empty_test(@album, :songs)
    end
  end
end
