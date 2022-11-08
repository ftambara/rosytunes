class MusicbrainzApiClient
  class << self
    def search(mb_model, query:)
      response_hash = search_request(mb_model.entity_name, query)
      response_hash[mb_model.entity_name.pluralize]
    end

    private
      def api_root = "https://musicbrainz.org/ws/2/"

      def search_limit = 16

      def user_agent_header
        { "RosyTunes/unreleased": ENV["MUSICBRAINZ_CONTACT"] }
      end

      def search_request(entity_name, query)
        request_string = "#{api_root}#{entity_name}"
        JSON.parse(RestClient.get(request_string,
                                   params: { query:, limit: search_limit },
                                   accept: :json,
                                   **user_agent_header))
      end
  end
end
