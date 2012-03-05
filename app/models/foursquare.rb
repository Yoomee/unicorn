CLIENT_ID = "RNUCMNSYCSB5Y5ILJV21RDOTZIGU1XQ14URQJYJU0GMGKIU5"
CLIENT_SECRET = "ZDWN011RQN1U25LKZDV4Q00I1GVF3XN2DW4MKDQF4J0MYXH2"

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

    def get_trending(lat, lng)
      get("/v2/venues/trending", :query => {:ll => "#{lat},#{lng}", :radius => 1500, :limit => 50})
    end

    def venue(id)
      get("/v2/venues/#{id}")
    end

    def grid(center = [30.2745, -97.7390], radius=3)
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
        puts " > Point #{idx + 1}/#{points.size}"
        venues += get_venues(point[0],point[1])["response"]["venues"] || []
      end
      venues.uniq!{|v| v["id"]}
    end
    
  end
end