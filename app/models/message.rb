class Message < ActiveRecord::Base
  validates :text, :presence => true
  
  def self.message
    first || create(:text => "Welcome... the countdown to SXSW has begun. I'm not yet in Austin, but will be there shortly. Check back in a few days to see the cool places where I will be hanging out.\n\nIn the meantime, press OK to see some of my favourite locations. Naaayyy!!", :button_text => "Ok", :button_hidden => false, :repeat_count => 5)
  end
end