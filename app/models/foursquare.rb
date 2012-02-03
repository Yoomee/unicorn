CLIENT_ID = "RNUCMNSYCSB5Y5ILJV21RDOTZIGU1XQ14URQJYJU0GMGKIU5"
CLIENT_SECRET = "ZDWN011RQN1U25LKZDV4Q00I1GVF3XN2DW4MKDQF4J0MYXH2"

class Foursquare
  include HTTParty
  base_uri 'https://api.foursquare.com'
  default_params :client_id => CLIENT_ID, :client_secret => CLIENT_SECRET, :v => '20120104'
 
  def self.get_venues(ne, sw)
    get("/v2/venues/search", :query => {:ne => ne, :sw => sw, :intent => 'browse', :limit => 5})
  end
  
  def self.get_trending(lat, lng)
    get("/v2/venues/trending", :query => {:ll => "#{lat},#{lng}", :radius => 10000, :limit => 50})
  end
  
  def self.venue(id)
    get("/v2/venues/#{id}")
  end
end