CLIENT_ID = "RNUCMNSYCSB5Y5ILJV21RDOTZIGU1XQ14URQJYJU0GMGKIU5"
CLIENT_SECRET = "ZDWN011RQN1U25LKZDV4Q00I1GVF3XN2DW4MKDQF4J0MYXH2"
#USER_TOKEN = Rails.env.production? ? "5XIURRFI2SBOWJYS15AIAJ3FJ0Q5VBTHA1HCT3GDDERMXQDA" : "GUCRW4TMZOXV0EFDUVXJO3ALZLUI1A1LERX4KZELHSWIQWOF"
USER_TOKEN = "GUCRW4TMZOXV0EFDUVXJO3ALZLUI1A1LERX4KZELHSWIQWOF" #Force dev accoutn for now
CHECKIN_SHOUTS = [
 "I've moved!!!",
 "I've moved on",
 "Even unicorns check-in",
 "Chase me if you can",
 "Chase me here if you can",
 "Moving onto here",
 "Bored with the last place",
 "Naaay!Brrrrr!!",
 "Cliperty clop!",
 "Naayyyy!!",
 "Nay!",
 "EEEEE!!",
 "Coo wee, coo wee...",
 "*loud nasal snort*",
 "Where's the hay?",
 "Nom nom nom",
 "Where to next?",
 "Having fun? I am.",
 "The magic is here ->",
 "Chasing dreams. Come join me!",
 "Tranquility to be found here ->",
 "Chasing me is futile",
 "I am here now",
 "At one with the world",
 "Come ride with me",
 "Party with me!",
 "Do you believe?",
 "The magic is definitely here",
 "Let me guide you",
 "*chortle*",
 "You are so missing out",
 "This is so much better",
 "Gamboling about",
 "Frolicking",
 "Skipping joyfully",
 "Cavorting",
 "Prancing",
 "Horny",
 "Prancing about",
 "Strutting here",
 "Fancy strutting with me?",
 "Leaping with joy",
 "Leaping",
 "Leaping excitedly",
 "Wondering where next?",
 "Dancing",
 "Bump me",
 "Follow the crowd",
 "Checking in",
 "Even unicorns check-in",
 "Are you here too?",
 "Here too?",
 "Rocking the house",
 "Having a better time than you",
 "Chilling out",
 "Wohooo! Chase me if you can!",
 "Wohoo! Chase me loser!",
 "Chase me loser!",
 "Neighhh!!",
 "Here first!",
 "Unicorns love to check in",
 "Where next?"
]

class Foursquare
  include HTTParty
  base_uri 'https://api.foursquare.com'
  default_params :client_id => CLIENT_ID, :client_secret => CLIENT_SECRET, :v => '20120104'

  class << self

    def get_venues(lat, lng)
      get("/v2/venues/search", :query => {:ll => "#{lat},#{lng}", :radius => 1500, :intent => 'browse', :limit => 50})
    end
    
    def get_venue(fsid)
      get("/v2/venues/#{fsid}")
    end
    
    def get_here_now_users(venue)
      res = get("/v2/venues/#{venue.fsid}/herenow", :query => {:oauth_token => USER_TOKEN, :limit => 500})["response"]
      items_data = res["hereNow"]["items"]
      offset = 500
      while res["hereNow"]["count"] > offset
        items_data += get("/v2/venues/#{venue.fsid}/herenow", :query => {:oauth_token => USER_TOKEN, :limit => 500, :offset => offset})["response"]["hereNow"]["items"]
        offset += 500
      end
      items_data.collect do |item_data|
        FoursquareUser.from_hash(item_data["user"])
      end
    end

    def get_trending(lat, lng)
      get("/v2/venues/trending", :query => {:ll => "#{lat},#{lng}", :radius => 1500, :limit => 50})
    end
    
    def get_categories
      get("/v2/venues/categories")
    end
    
    def checkin(venue,message = nil)
      message = CHECKIN_SHOUTS.sort_by{rand}.first if message.blank?
      post("/v2/checkins/add", :query => {"venueId" => venue.fsid, :oauth_token => USER_TOKEN, :shout => "#{message} #SXSW", :broadcast => 'public,twitter'})
    end

    def venue(id)
      get("/v2/venues/#{id}")
    end
    
    def fetch_categories
      root_categories = get_categories["response"]["categories"]
      root_categories.each {|cat_data| Category.from_api(cat_data)}
    end

    def grid(center, radius)
      width = radius * 2
      lat_min, lng_min, lat_max, lng_max = Geocoder::Calculations::bounding_box(center,radius)
      lats,lngs = [], []
      (width + 1).times do |n|
        lats << lat_min + (((lat_max - lat_min)/width)*n) 
        lngs << lng_min + (((lng_max - lng_min)/width)*n) 
      end
      [].tap do |points|
        lats.each do |lat|
          lngs.each do |lng|
            points << [lat.round(5),lng.round(5)]
          end
        end
      end
    end
    
    def get_trending_with_grid(lat,lng,grid_radius)
      venues = []
      points = grid([lat,lng],grid_radius)
      points.each_with_index do |point,idx|
        venues += get_venues(point[0],point[1])["response"]["venues"] || []
      end
      venues.uniq!{|v| v["id"]}
    end
    
  end
end