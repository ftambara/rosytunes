class MbAdapter
  class << self
    module Diggable
      def dig(entity_hash, path)
        path.inject(entity_hash) do |result, attr|
          result[attr]
        end
      end
    end

    class Value
      include Diggable

      def initialize(*path)
        @path = path
      end

      def dig(entity_hash)
        super entity_hash, @path
      end
    end

    class Collection
      include Diggable
      def initialize(model, ext_path, diggable)
        @model    = model
        @ext_path = ext_path
        @diggable = diggable
      end

      def dig(entity_hash)
        sub_entities = (super entity_hash, @ext_path).map do |sub_entity|
          @diggable.dig(sub_entity)
        end
        @model.mb_adapter.models_from_entities(sub_entities)
      end
    end


    def models_from_entities(entities_list)
      entities_list.map { |entity| entity_to_model(entity) }
    end

    private
      def entity_to_model(mb_entity)
        attr_map = {}
        mappings.each do |attr, digger|
          if (value = digger.dig(mb_entity))
            attr_map[attr] = value
          end
        end
        model.new(**attr_map)
      end
  end
end

