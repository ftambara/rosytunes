class MusicLibraryGateway
  class << self
    def list_of(mappable, matching:)
      # matching: query string
      return [] if matching.blank?
      entities_list = client.search(mappable, query: matching)
      mappable.models_from_entities(entities_list)
    end

    def fill_details(model_class)
    end

    private
      def client = MusicbrainzApiClient
  end
end
