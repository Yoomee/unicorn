class MessagesController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def edit
    @message = Message.message
  end
  
  def update
    @message = Message.message
    if @message.update_attributes!(params[:message])
      redirect_to message_path
    else
      render :action => 'edit'
    end
  end
  
  def show
    @message = Message.message
  end
end