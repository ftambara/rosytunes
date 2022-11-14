class AlbumsController < ApplicationController
  def index
    @albums = if (query = params[:query])
                Album.search(query)
              elsif user_signed_in?
                # get user saved albums
              end
  end

  def show
    @album = Album.find(params[:id])
  end
end
