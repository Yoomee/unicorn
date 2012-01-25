require 'twitter.rb'

class HomeController < ApplicationController
  before_filter :fetch_tweets
  def index
  end
  
  private
  def fetch_tweets
    @tweets = Rails.cache.fetch("tweets_#{I18n.locale}", :expires_in => 30.minutes) do
      Twitter.search("##{t(:hash_tag)}")
    end
  end
end