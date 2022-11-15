class ArtistsController < ApplicationController
  def index
    @artists = if (query = params[:query])
      Artist.search(query)
    elsif user_signed_in?
      # get user saved artists
    end
  end

  def show
    @artist = Artist.find(params[:id])
  end
end
