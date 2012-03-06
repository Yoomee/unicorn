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
    print "Prodding the Unicorn: \n > "

    minutes_since_move = 1000 #Visit.first.present? ? (Time.current - Visit.order(:arrived_at).last.arrived_at) / 60 : 10000
    if minutes_since_move < RandomGaussian.new(60, 15).rand #Moved too recently
      puts " > It's too soon to move"
    else
      recent_venues = Visit.order('arrived_at DESC').limit(5).collect(&:venue)
      
      #Get popular venues, those with the most here_now
      popular_venues = Venue.not_blacklisted.order('here_now DESC').limit(6)
      popular_venue = popular_venues.reject{|v| recent_venues.include?(v)}.first
      
      #Get events that are on at the moment
      current_events = Event.where("starts_at <= ? AND ends_at >= ?",Time.current, Time.current).sort_by{|e| e.venue.here_now}.reverse
      event = current_events.reject{|e| recent_venues.include?(e.venue)}.first
      
      if event && ((event.venue.here_now * 3) > popular_venue.here_now)
        event = events.first
        event.venue.visits.create(:arrived_at => Time.current, :event => event)
        puts "He's moved to the event #{event.name}"
        #Foursquare.checkin(venue)
      else
        popular_venue.visits.create(:arrived_at => Time.current)
        #Foursquare.checkin(venue)
        puts "He's moved to #{popular_venue.name}"
      end
    end
  end
end