class AppUsersController < ApplicationController
  layout 'admin' 
  before_filter :authenticate

  def index
    @app_users = AppUser.order('created_at DESC').paginate(:page => params[:page], :per_page => 50)
  end
end