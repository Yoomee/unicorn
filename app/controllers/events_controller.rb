class EventsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  def new
    @event = Event.new
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_path
    else
      render :action => 'new'
    end
  end
  
  def index
    @events = Event.all
  end
end