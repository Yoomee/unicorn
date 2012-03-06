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
    popular_venues = Venue.order('here_now DESC').limit(6)
    puts popular_venues.collect(&:id).to_s
    recent_venues = Visit.order('arrived_at DESC').limit(5).collect(&:venue)
    puts recent_venues.collect(&:id).to_s
    popular_venues.reject!{|v| recent_venues.include?(v)}
    venue = popular_venues.first
    venue.visits.create(:arrived_at => Time.current)
    puts "The unicorn has moved to #{venue.name}"
  end
end