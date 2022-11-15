module CanAccessLibrary
  extend ActiveSupport::Concern

  def fill_attributes
    self.class.fill_attributes_for(self) if api_id
  end

  class_methods do
    def lib_attr_accessor(*methods)
      methods.each do |method|
        attr_writer(method)
        define_method(method) do
          if (value = instance_variable_get("@#{method}"))
            value
          elsif api_id
            fill_attributes
            instance_variable_get("@#{method}")
          end
        end
      end
    end

    def search(query, persist: true)
      gateway.list_of(self, query, persist:)
    end

    def api_mapper = ApiMapper.const_get(self.name)

    def fill_attributes_for(model)
      gateway.find(model)
    end

    private
      def gateway = MusicLibraryGateway.new
  end
end
