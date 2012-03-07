class AppUsersController < ApplicationController
  layout 'admin' 
  before_filter :authenticate

  def index
    @app_users = AppUser.order('created_at DESC').paginate(:page => params[:page], :per_page => 50)
    api_call_counts = ApiCallLog.where("created_at > ?",2.days.ago).order('created_at ASC').group_by{|a| a.created_at.strftime("%d %H")}
    day = 2.days.ago.day
    hour = 2.day.ago.hour
    @data = []
    24.times do |idx|
      @data << [hour.to_s,api_call_counts["#{"%02d" % day} #{"%02d" % hour}"].try(:size).to_i]
      if hour == 23
        hour = 0
        day += 1
      else
        hour += 1
      end
    end
  end
end