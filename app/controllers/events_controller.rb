class EventsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  def new
    @event = Event.new
  end
  
  def edit
    @event = Event.find(params[:id])
  end
  
  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to events_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path
  end
  
  def update
    @event = Event.find(params[:id])
    if @event.update_attributes!(params[:event])
      redirect_to events_path
    else
      render :action => 'edit'
    end
  end
  
  def index
    @events = Event.order('starts_at ASC')
  end
end