class ApisController < ApplicationController
  #before_filter :get_venues
  before_filter :log_user
  def show
    #sleep 30
    if params[:v] == "1.2"
      venues = ActiveSupport::JSON.decode(File.read(File.join(Rails.root, "lib", "venues.json")))
      message = {:text => "Welcome to the Unicorn tracker!\n\nThe unicorn has embarked on its mysterious journey to South by South West and is due to touch down in Austin on March 9.\n\nCheck back then to share in its magic.", :button_text => "Ok", :button_hidden => false}
      message[:id] = params[:m].to_i < 5 ? params[:m].to_i + 1 : 5
      render :json => {:message => message, :venues => venues}
    else
      venues = ActiveSupport::JSON.decode(File.read(File.join(Rails.root, "lib", "venues.json")))
      message = {:text => "Welcome to the Unicorn tracker!\n\nThe unicorn has embarked on its mysterious journey to South by South West and is due to touch down in Austin on March 9.\n\nCheck back then to share in its magic.", :button_text => "Ok", :button_hidden => false}
      message[:id] = params[:m].to_i < 5 ? params[:m].to_i + 1 : 5
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