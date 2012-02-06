class ApisController < ApplicationController
  def show
    get_venues
    #render :json => {}
    #render :json => {:venues => @venues, :message => {:text => "Hello Ian!", :button_text => "Bonza", :button_hidden => false, :id => 4}}
    render :file => File.join(Rails.root, "lib", "venues.json")
  end
  
  private
  def get_venues
    @venues = Rails.cache.fetch("venues", :expires_in => 1.minute) do
      #Sheff  "53.3933,-1.4452","53.3625,-1.5123"
      #Austin "30.321, -97.713","30.241, -97.761"

      #Aim for a 10km square centering on middle of Austin

      res = Foursquare.get_venues("53.3933,-1.4452","53.3625,-1.5123")["response"]

      #res = Foursquare.get_trending(53.37,-1.48)["response"]
      #res = Foursquare.get_trending(40.7,-74)["response"] #New York
      res["venues"].collect{|v| Venue.new(v)}.sort_by(&:here_now).reverse
    end
  end
  
end