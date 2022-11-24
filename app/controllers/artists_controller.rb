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
    @bookmark = get_bookmark(current_user, @artist) if user_signed_in?
  end

  def get_bookmark(user, artist)
    ArtistBookmark.find_by(user:, artist:)
  end
end
