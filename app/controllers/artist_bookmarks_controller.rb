class ArtistBookmarksController < ApplicationController
  before_action :authwall_if_disallowed
  before_action :set_user

  def create
    @bookmark = ArtistBookmark.new(user: @user, **bookmark_params)

    respond_to do |format|
      if @bookmark.save
        format.html { redirect_back_or_to(user_path(current_user)) }
      else
        format.html do
          redirect_back_or_to(user_path(current_user),
            error: "Could not create a rating.")
        end
      end
    end
  end

  def destroy
    @bookmark = ArtistBookmark.find(params[:id])
    @bookmark.destroy

    respond_to do |format|
      format.html { redirect_back_or_to(root_path) }
    end
  end

  private
    def authwall_if_disallowed
      unless allowed_user?(params[:user_id])
        redirect_back_or_to(root_path, error: "That's not yours!")
      end
    end

    def allowed_user?(declared_id)
      signed_in? && declared_id.to_i == current_user.id
    end

    def set_user
      @user = current_user
    end

    def bookmark_params
      params.require(:artist_bookmark).permit(:artist_id)
    end
end
