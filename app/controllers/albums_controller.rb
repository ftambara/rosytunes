class AlbumsController < ApplicationController
  def index
    if (query = params[:query])
      @albums = Album.search(query:)
    end
  end
end
