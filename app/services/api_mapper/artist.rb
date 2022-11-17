module ApiMapper
  class Artist < Base
    class << self
      def api_class = RSpotify::Artist

      def fill_flat_attributes(api_model, app_model)
        app_model.name         = api_model.name
        app_model.cover        = api_model.images&.last&.fetch("url")
        app_model.external_uri = api_model.uri
      end

      def fill_collections(api_model, app_model)
        albums = get_full_collection(
          api_model, :albums, filters: { album_type: "album" })
        app_model.albums = albums.map do |album|
          ApiMapper::Album.api_to_app_model(album, shallow: true)
        end
      end
    end
  end
end
