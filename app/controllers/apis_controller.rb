class ApisController < ApplicationController
  def show
    render :file => File.join(Rails.root, "lib", "venues.json"), :layout => false
  end
end