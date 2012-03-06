class Event < ActiveRecord::Base
  belongs_to :venue
  has_many :visits
  validates :venue, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  
  before_validation :create_venue_from_foursquare_id
  attr_accessor :venue_foursquare_id
  
  def formatted_starts_at
    starts_at.try(:strftime, '%Y-%m-%d %H:%M')
  end
  
  def formatted_ends_at
    ends_at.try(:strftime, '%Y-%m-%d %H:%M')
  end
  
  private
  def create_venue_from_foursquare_id
    if venue_foursquare_id.present?
      self.venue = Venue.from_foursquare_id(venue_foursquare_id)
    end
  end
end