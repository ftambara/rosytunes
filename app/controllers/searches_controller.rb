class SearchesController < ApplicationController
  def new
  end

  def delegate
  end

  private
    def search_params
      params.require(:search).permit(:entity, :query)
    end
end
