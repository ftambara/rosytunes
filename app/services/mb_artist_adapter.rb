class MbArtistAdapter < MbAdapter
  class << self
    def entity_name = "artist"

    private
      def model = Artist

      def mappings
        {
          mbid: Value.new("id"),
          name: Value.new("name"),
        }
      end
  end
end
