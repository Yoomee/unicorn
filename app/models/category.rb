class Category < ActiveRecord::Base
  has_many :venue_categories
  has_many :venues, :through => :venue_categories
  
  def icon_url
    "#{icon_prefix}32#{icon_extension}"
  end
end