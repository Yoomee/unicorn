class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  private
  def set_locale
    if (request.host =~ /mandacalcetines\.org/) || params[:hl] == "es"
      I18n.locale = :es
    else
      I18n.locale = :en
    end
  end
end
