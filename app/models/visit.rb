class Visit < ActiveRecord::Base
  belongs_to :venue
  belongs_to :event
  has_and_belongs_to_many :foursquare_users
  before_create :checkin_and_fetch_users
  
  def as_json(options)
    if event && event.name.present?
      name = event.name
      address = [venue.name,venue.address].join(', ')
    else
      name = venue.name
      address = venue.address
    end
    {
      :id => venue.fsid,
      :name => name,
      :location => {
        :address => address,
        :city => venue.city,
        :state => venue.state,
        :country => venue.country,
        :lat => venue.lat,
        :lng => venue.lng
      },
      :hereNow => {
        :count => venue.here_now
      }
    }
  end
  
  private
  def checkin_and_fetch_users
    if SiteSetting.find_by_name("fourquare_checkins_enabled").value == "YES"
      Foursquare.checkin(venue,event.try(:checkin_message))
      self.foursquare_users = Foursquare.get_here_now_users(venue)
    end
  end
end