module ApiMapper
  class Base
    class << self
      def api_to_app_model(api_model, persist: true, shallow: true)
        api_id = api_model.id
        app_model = persist ?
          target_model_class.find_or_create_by(api_id:) :
          target_model_class.find_or_initialize_by(api_id:)
        transfer_into_model(api_model, app_model, shallow:)
        app_model
      end

      def transfer_into_model(api_model, app_model, shallow: false)
        fill_collections(api_model, app_model) unless shallow
        fill_flat_attributes(api_model, app_model)
        app_model
      end

      private
        def target_model_class
          const_get(name.rpartition("::").last)
        end

        def get_full_collection(api_model, api_attr, filters: {})
          limit, offset = 50, 0
          results = []
          loop do
            collection = api_model.send(api_attr, limit:, offset:, **filters)
            offset += limit
            results += collection
            break if collection.size < limit
          end
          results
        end

    end
  end
end
