class AdminController < ApplicationController
  USERS = { "yoomee" => "olive123" }
  layout 'admin'
 
  before_filter :authenticate
  
  def index
    @app_users = AppUser.all
  end
 
  private
 
  def authenticate
    authenticate_or_request_with_http_digest do |username|
      USERS[username]
    end
  end
end