class SearchesController < ApplicationController
  def new
  end

  def delegate
    entity, query = search_params.values_at(:entity, :query)
    unless helpers.searchable_entities.include?(entity)
      render :new, errors:
        "Entity must be one of [#{helpers.searchable_entities.join(", ")}]"
    end
    redirect_to send(delegate_url_helper(entity), params: { query: })
  end

  private
    def search_params
      params.require(:search).permit(:entity, :query)
    end

    def delegate_url_helper(entity)
      "#{entity.downcase.pluralize}_path"
    end
end
