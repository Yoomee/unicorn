class Venue < ActiveRecord::Base
  has_many :venue_categories, :dependent => :destroy
  has_many :categories, :through => :venue_categories
  has_many :events
  has_many :visits
  
  scope :not_blacklisted, joins(:categories).where("categories.blacklisted = false")
  
  Venue::AUSTIN = [30.2745, -97.7390]
  class << self
    def get_trending(center,radius)
      Foursquare.get_trending_with_grid(center[0], center[1],radius).each do |venue_data|
        from_hash(venue_data)
      end
    end

    def from_foursquare_id(fsid)
      from_hash(Foursquare.get_venue(fsid)["response"]["venue"])
    end

    def from_hash(venue_data)
      venue = find_or_initialize_by_fsid(venue_data["id"])
      venue.update_attributes!({  
        :name => venue_data["name"],
        :address => venue_data["location"]["address"],
        :postal_code => venue_data["location"]["postalCode"],
        :city => venue_data["location"]["city"],
        :state => venue_data["location"]["state"],
        :country => venue_data["location"]["country"],
        :lat => venue_data["location"]["lat"],
        :lng => venue_data["location"]["lng"],
        :verified => venue_data["verified"],
        :checkins_count => venue_data["stats"]["checkinsCount"],
        :users_count => venue_data["stats"]["usersCount"],
        :tip_count => venue_data["stats"]["tipCount"],
        :here_now => venue_data["hereNow"]["count"]
        })
      venue_data["categories"].each do |cat_data|
        category = Category.from_api(cat_data)
        vc = venue.venue_categories.find_or_initialize_by_category_id(category.id)
        vc.update_attribute(:primary, cat_data["primary"])
      end
      venue
    end
  end

  def as_json(options)
    {
      :id => fsid,
      :name => name,
      :location => {
        :address => address,
        :city => city,
        :state => state,
        :country => country,
        :lat => lat,
        :lng => lng
      },
      :hereNow => {
        :count => here_now
      }
    }
  end
  
  def primary_category
    categories.where("venue_categories.primary = true").first
  end
  
  def lat_lng
    "#{location["lat"]},#{location["lng"]}"
  end
  
  def fs_url
    "http://foursquare.com/v/#{fsid}"
  end
end