class MbAlbumAdapter < MbAdapter
  class << self
    def entity_name = "release-group"

    private
      def model = Album

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
