class FoursquareUser < ActiveRecord::Base
  has_and_belongs_to_many :visits  
  scope :frequent_visitors, select("foursquare_users.*, sum(visits.id) as visits_count").joins(:visits).group('foursquare_users.id').order('visits_count DESC')
  
  def self.from_hash(user_data)
    find_by_fsid(user_data["id"]) || new({
      :fsid => user_data["id"],
      :first_name => user_data["firstName"],
      :last_name => user_data["lastName"],
      :photo => user_data["photo"],
      :gender => user_data["gender"],
      :home_city => user_data["homeCity"],
      :canonical_url => user_data["canonicalUrl"],
    })
  end
  
  def name
    "#{first_name} #{last_name}"
  end
end