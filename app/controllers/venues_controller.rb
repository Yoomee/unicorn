class VenuesController < ApplicationController
  layout 'admin'
  before_filter :authenticate  
  def index
    @venues = Venue.order("here_now DESC").paginate(:page => params[:page], :per_page => 50)
  end
end