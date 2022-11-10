class AlbumsController < ApplicationController
  def index
    @albums = if (query = params[:query])
                Album.search(query)
              else
                Album.order(:release_date)
              end
  end

  def show
    @album = Album.includes(:artists, :songs).find(params[:id])
  end
end
