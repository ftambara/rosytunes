module ApiMapper
  class Artist < Base
    class << self
      def api_class = RSpotify::Artist

      def api_attr_mappings
        {
          id: :api_id,
          name: :name
        }
      end
    end
  end
end
