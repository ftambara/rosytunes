class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    unless @user.id == params[:id].to_i
      redirect_back_or_to root_path,
        notice: "For the moment, user profile pages are private"
    end
  end
end
