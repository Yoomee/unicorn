class VisitsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def index
    @visits = Visit.order('arrived_at DESC').paginate(:page => params[:page], :per_page => 50)
  end

end