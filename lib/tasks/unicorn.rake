namespace :venues do
  desc "Refresh venue data from Foursquare"
  task :refresh => :environment do
    print "Refreshing venue data: \n > "
    Venue.get_trending(Venue::AUSTIN, 4)
    puts "Complete"
  end
end

namespace :unicorn do
  desc "Move"
  task :move => :environment do
    print "Prodding the Unicorn: \n > "
    minutes_since_move = Visit.first.present? ? (Time.current - Visit.order(:arrived_at).last.arrived_at) / 60 : 10000
    if minutes_since_move < 0#(45 + (30*Kernel.rand))
      puts "It's too soon to move"
    else
      recent_venues = Visit.order('arrived_at DESC').limit(5).collect(&:venue)
      
      #Get popular venues, those with the most here_now
      popular_venues = Venue.not_blacklisted.order('here_now DESC').limit(6)
      popular_venue = popular_venues.reject{|v| recent_venues.include?(v)}.first
      
      #Get events that are on at the moment
      current_events = Event.where("starts_at <= ? AND ends_at >= ?",Time.current, Time.current).sort_by{|e| e.venue.here_now}.reverse
      event = current_events.reject{|e| recent_venues.include?(e.venue)}.first
      
      if event #&& ((event.venue.here_now * 3) > popular_venue.here_now) Event always wins
        event.venue.visits.create(:arrived_at => Time.current, :event => event, :here_now => event.venue.here_now)
        puts "He's moved to the event #{event.name}"
        Foursquare.checkin(event.venue,event.checkin_message)
      else
        popular_venue.visits.create(:arrived_at => Time.current, :here_now => popular_venue.here_now)
        #Foursquare.checkin(popular_venue)
        puts "He's moved to #{popular_venue.name}"
      end
    end
  end
end