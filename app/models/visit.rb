class Visit < ActiveRecord::Base
  belongs_to :venue
  belongs_to :event
  has_and_belongs_to_many :foursquare_users
  before_create :fetch_here_now
  
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
  def fetch_here_now
    self.foursquare_users = Foursquare.get_here_now_users(venue)
  end
end