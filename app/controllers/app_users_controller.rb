class AppUsersController < ApplicationController
  layout 'admin' 
  before_filter :authenticate

  def index
    @app_users = AppUser.paginate(:page => params[:page], :per_page => 200)
  end
end