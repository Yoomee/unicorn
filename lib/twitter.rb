class Twitter
  include HTTParty
  base_uri 'http://search.twitter.com'
  
  Twitter::BLACK_LIST = File.readlines("#{Rails.root}/lib/blacklist.txt").map{|w| w.strip.downcase}
  
  def self.search(term)
    tweets = get('/search.json', :query => {:q => URI.encode(term), :rpp => 30})["results"]
    tweets.reject do |tweet|
      tweet["text"].split(/[^\w]/).any?{|word| Twitter::BLACK_LIST.include?(word.downcase)}
    end
  end
  
end