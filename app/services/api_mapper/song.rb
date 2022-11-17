module ApiMapper
  class Song < Base
    class << self
      def api_class = RSpotify::Track

      def fill_flat_attributes(api_model, app_model)
        app_model.name = api_model.name
        app_model.length_in_s = (api_model.duration_ms / 1000).floor
      end

      def fill_collections(api_model, app_model)
      end
    end
  end
end
