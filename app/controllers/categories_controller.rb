class CategoriesController < ApplicationController
  layout 'admin'
  before_filter :authenticate
  
  def blacklist
    @category = Category.find(params[:id])
    @category.update_attribute(:blacklisted,true)
  end
  
  def unblacklist
    @category = Category.find(params[:id])
    @category.update_attribute(:blacklisted,false)
    render :action => 'blacklist'
  end
  
  def index
    @categories = Category.where(:super_category_id => nil).order(:name)
  end
end