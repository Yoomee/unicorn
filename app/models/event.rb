class Event < ActiveRecord::Base
  belongs_to :venue
  attr_accessor :venue_foursquare_id
end