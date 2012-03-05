class ApisController < ApplicationController
  #before_filter :get_venues
  before_filter :log_user
  def show
    #venues = Visit.order('arrived_at DESC').limit(5).collect(&:venue)
    venues = ActiveSupport::JSON.decode(File.read(File.join(Rails.root, "lib", "venues.json")))
    if params[:v] == "1.2"
      if Message.message.button_hidden || (@app_user.api_call_logs.where("created_at > ?",Message.message.updated_at).count < Message.message.repeat_count)
        message = Message.message
      else
        message = nil
      end
      render :json => {:message => message, :venues => venues}
    else
      message = Message.message
      message[:id] = params[:m].to_i < 10 ? params[:m].to_i + 1 : 10
      render :json => {:message => message, :venues => venues}
    end
  end
  
  private
  def get_venues
    @venues = Rails.cache.fetch("venues", :expires_in => 1.minute) do
      #Sheff  "53.3933,-1.4452","53.3625,-1.5123"
      #Austin "30.321, -97.713","30.241, -97.761"
      #Aim for a 10km square centering on middle of Austin
      res = Foursquare.get_venues("30.321, -97.713","30.241, -97.761")["response"]
      #res = Foursquare.get_trending(53.37,-1.48)["response"]
      #res = Foursquare.get_trending(40.7,-74)["response"] #New York
      res["venues"].collect{|v| Venue.new(v)}.sort_by(&:here_now).reverse
    end
  end
  
  def log_user
    @app_user = AppUser.find_or_create_by_uuid(params[:uuid])
    @app_user.api_call_logs.create(:app_version => params[:v], :message_id => params[:m], :lat => params[:lat], :lng => params[:lng], :ip_address => request.remote_ip)
  end
  
end