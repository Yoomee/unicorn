require 'random_gaussian'

namespace :venues do
  desc "Refresh venue data from Foursquare"
  task :refresh => :environment do
    puts "Refreshing venue data"
    Venue.get_trending(Venue::AUSTIN, 4)
    puts "Complete"
  end
end

namespace :unicorn do
  desc "Move"
  task :move => :environment do
    puts "Asking the unicorn if he's ready to move on..."
    minutes_since_move = Visit.first.present? ? (Time.current - Visit.order(:arrived_at).last.arrived_at) / 60 : 10000
    if minutes_since_move < RandomGaussian.new(60, 15).rand
      puts "Too soon!"
    else
      popular_venues = Venue.not_blacklisted.order('here_now DESC').limit(6)
      recent_venues = Visit.order('arrived_at DESC').limit(5).collect(&:venue)
      popular_venues.reject!{|v| recent_venues.include?(v)}
      venue = popular_venues.first
      venue.visits.create(:arrived_at => Time.current)
      Foursquare.checkin(venue)
      puts "The unicorn has moved to #{venue.name}"
    end
  end
end