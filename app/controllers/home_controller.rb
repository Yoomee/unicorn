class HomeController < ApplicationController
  #before_filter :redirect_to_twitter
  def index
  end
  
  def faq
    redirect_to_twitter
  end
  
  private
  def redirect_to_twitter
    redirect_to "https://twitter.com/sxswunicorn" if Rails.env.production?
  end
end