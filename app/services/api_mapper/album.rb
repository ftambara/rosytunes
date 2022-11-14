module ApiMapper
  class Album < Base
    class << self
      def api_class = RSpotify::Album

      ApiAttrMapping = Struct.new(:api_attr, :app_attr)
      def api_attr_mappings
        {
        # API attr      App attr
          id:           :api_id,
          name:         :name,
          release_date: :release_date,
          album_type:   :release_type,
          artists:      :artists
        }
      end

      def api_value_mappings
        {
        # API attr    API value to app mapping function
          album_type: ->(value) do
            case value
            when "album"       then "Album"
            when "single"      then "Single"
            when "compilation" then "Compilation"
            end
          end,
          artists: ->(value) do
            value.map do |artist|
              ::Artist.api_mapper.api_to_app_model(artist)
            end
          end
        }
      end
    end
  end
end
