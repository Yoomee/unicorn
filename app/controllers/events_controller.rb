class EventsController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  def new
    @event = Event.new
  end
end