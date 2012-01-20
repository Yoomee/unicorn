class Twitter
  include HTTParty
  base_uri 'http://search.twitter.com'
  
  def self.search(term)
    get '/search.json', :query => {:q => URI.encode(term), :rpp => 20}
  end
  
end