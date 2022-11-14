module ApiMapper
  class Base
    class << self
      def api_to_app_model(api_model)
        attr_map = {}
        api_attr_mappings.each do |api_attr, model_attr|
          api_value = api_model.send(api_attr)
          attr_map[model_attr] = convert_api_value(api_attr, api_value)
        end
        target_model_class.find_by(api_id: attr_map[:api_id]) ||
          target_model_class.new(**attr_map)
      end

      def api_values_into_model(api_model, model)
        api_attr_mappings.each do |api_attr, model_attr|
          api_value = api_model.send(api_attr)
          model.send("#{model_attr}=", convert_api_value(api_attr, api_value))
        end
        model
      end

      private
        def target_model_class
          const_get(name.rpartition("::").last)
        end

        def convert_api_value(api_attr, api_value)
          mapping_function = api_value_mappings[api_attr]
          mapping_function&.call(api_value) || api_value
        end

        # Override on subclasses that need it
        def api_value_mappings = {}
    end
  end
end
