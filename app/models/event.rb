class Event < ActiveRecord::Base
  belongs_to :venue
  validates :venue, :presence => true
  before_validation :create_venue_from_foursquare_id
  attr_accessor :venue_foursquare_id
  
  private
  def create_venue_from_foursquare_id
    if venue_foursquare_id.present?
      self.venue = Venue.from_foursquare_id(venue_foursquare_id)
    end
  end
end