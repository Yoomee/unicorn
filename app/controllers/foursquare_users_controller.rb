class FoursquareUsersController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @foursquare_users = FoursquareUser.frequent_visitors.paginate(:page => params[:page], :per_page => 50)
  end

end