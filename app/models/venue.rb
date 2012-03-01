class Venue < ActiveRecord::Base
  has_many :venue_categories, :dependent => :destroy
  has_many :categories, :through => :venue_categories
  has_many :events
  class << self
    def get_trending(center,radius)
      Foursquare.get_trending_with_grid(center[0], center[1],radius).each do |venue_data|
        from_json(venue_data)
      end
    end

    def from_foursquare_id(fsid)
      from_json(Foursquare.get_venue(fsid)["response"]["venue"])
    end

    def from_json(venue_data)
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
          category = Category.find_or_initialize_by_fsid(cat_data["id"])
          category.update_attributes!({
            :name => cat_data["name"],
            :plural_name => cat_data["pluralName"],
            :short_name => cat_data["shortName"],
            :icon_prefix => cat_data["icon"]["prefix"],
            :icon_extension => cat_data["icon"]["name"]
            })
            vc = venue.venue_categories.find_or_initialize_by_category_id(category.id)
            vc.update_attribute!(:primary, cat_data["primary"])
          end
        end
      end

      def primary_category
        categories.where("venue_categories.primary = 1").first
      end

      def lat_lng
        "#{location["lat"]},#{location["lng"]}"
      end

      def fs_url
        "http://foursquare.com/v/#{fsid}"
      end

    end