class SiteSettingsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    SiteSetting.find_by_name("fourquare_checkins_enabled") || SiteSetting.create(:name => "fourquare_checkins_enabled", :value => "YES")
    @site_settings = SiteSetting.all
  end
  
  def edit
    @site_setting = SiteSetting.find(params[:id])
  end
  
  def update
    @site_setting = SiteSetting.find(params[:id])
    if @site_setting.update_attributes!(params[:site_setting])
      redirect_to site_settings_path
    else
      render :action => 'edit'
    end
  end

end