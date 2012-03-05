class VenuesController < ApplicationController
  layout 'admin'
  before_filter :authenticate  
  AUSTIN = [30.2745, -97.7390]
  def index
    @venues = Venue.order("here_now DESC").paginate(:page => params[:page], :per_page => 50)
  end
  
  def reload
    Venue.get_trending(AUSTIN, 4)
    redirect_to venues_path
  end
end