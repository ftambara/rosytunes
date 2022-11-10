class MbArtistAdapter < MbAdapter
  class << self
    def entity_name = "artist"

    def model = Artist

    private
      def mappings
        {
          mbid: Value.new("id"),
          name: Value.new("name"),
        }
      end
  end
end
