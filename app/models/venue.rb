class Venue
  attr_reader :id, :name, :location, :here_now
  def initialize(params)
    @id = params["id"]
    @name = params["name"]
    @location = params["location"]
    @here_now = params["hereNow"]["count"]
  end
  
  def address
    location["address"]
  end
  
  def lat
    location["lat"]
  end
  
  def lat_lng
    "#{location["lat"]},#{location["lng"]}"
  end
  
  def lng
    location["lng"]
  end
end