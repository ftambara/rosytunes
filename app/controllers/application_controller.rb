class ApplicationController < ActionController::Base
  include AuthenticationHelper

  before_action :skip_header, if: :devise_controller?
end
