require 'resolv'
GEO_IP_DB = File.join(Rails.root,"lib/GeoLiteCity.dat")

class ApiCallLog < ActiveRecord::Base
  belongs_to :app_user
  before_save :get_location_from_ip
  
  def ip_location
    [ip_city, ip_country].select(&:present?).join(', ')
  end
  
  private 
  def get_location_from_ip
    return true unless (File.exists?(GEO_IP_DB) && ip_address =~ /\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/)
    res = GeoIP.new(GEO_IP_DB).city(ip_address)
    if res
      self.ip_city = res.city_name
      self.ip_country = res.country_name
      self.ip_lat = res.latitude
      self.ip_lng = res.longitude
    end
  end
end