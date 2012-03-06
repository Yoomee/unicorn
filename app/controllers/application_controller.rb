class ApplicationController < ActionController::Base
  protect_from_forgery
  USERS = { "yoomee" => "olive123" }
  private
  def authenticate
    return true unless Rails.env.production?
    authenticate_or_request_with_http_basic("What's the magic word?") do |username|
      USERS[username]
    end
  end
end
