class MbAlbumAdapter < MbAdapter
  class << self
    def entity_name = "release-group"

    def model = Album

    private
      def mappings
        {
          mbid: Value.new("id"),
          name: Value.new("title"),
          artists: Collection.new(Artist,
                                  ["artist-credit"],
                                  Value.new("artist"))
        }
      end
  end
end
