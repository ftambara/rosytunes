class SearchesController < ApplicationController
  def new
  end

  def delegate
    entity, query = search_params.values_at(:entity, :query)
    unless helpers.searchable_entities.include?(entity)
      render :new, errors:
        "Entity must be one of [#{helpers.searchable_entities.join(", ")}]"
    end
    entity_index_helper = "#{entity.downcase.pluralize}_path"
    redirect_to send(entity_index_helper, params: { query: })
  end

  private
    def search_params
      params.require(:search).permit(:entity, :query)
    end
end
