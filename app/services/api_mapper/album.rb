module ApiMapper
  class Album < Base
    class << self
      def api_class = RSpotify::Album

      def fill_flat_attributes(api_model, app_model)
        app_model.name         = api_model.name
        app_model.release_date = api_model.release_date
        app_model.release_type = convert_album_type(api_model.album_type)
        app_model.cover        = api_model.images.second["url"]
        app_model.external_uri = api_model.uri
      end

      def fill_collections(api_model, app_model)
        artists = get_full_collection(api_model, :artists)
        app_model.artists = artists.map do |artist|
          ApiMapper::Artist.api_to_app_model(artist, shallow: true)
        end

        songs = get_full_collection(api_model, :tracks)
        app_model.songs = songs.map do |song|
          ApiMapper::Song.api_to_app_model(song, shallow: true)
        end
      end

      def convert_album_type(api_album_type)
        case api_album_type
        when "album"       then "Album"
        when "single"      then "Single"
        when "compilation" then "Compilation"
        end
      end
    end
  end
end
