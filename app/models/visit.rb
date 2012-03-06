class Visit < ActiveRecord::Base
  belongs_to :venue
  belongs_to :event
  
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
end