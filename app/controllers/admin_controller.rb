class AdminController < ApplicationController
  layout 'admin' 
  before_filter :authenticate

  def index
    @app_users = AppUser.all
  end
end