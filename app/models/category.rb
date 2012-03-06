class Category < ActiveRecord::Base
  has_many :venue_categories
  has_many :venues, :through => :venue_categories
  
  belongs_to :super_category, :class_name => "Category"
  has_many :sub_categories, :class_name => "Category", :foreign_key => "super_category_id"
  
  class << self
    def from_api(cat_data,super_category = nil)
      category = find_or_initialize_by_fsid(cat_data["id"])
      category.update_attributes!({
        :name => cat_data["name"],
        :plural_name => cat_data["pluralName"],
        :short_name => cat_data["shortName"],
        :icon_prefix => cat_data["icon"]["prefix"],
        :icon_extension => cat_data["icon"]["name"],
        :super_category => super_category
      })
      if cat_data["categories"].present?
        cat_data["categories"].each do |sub_cat_data|
          from_api(sub_cat_data,category)
        end
      end
      category      
    end
  end
  
  def css_class
    cls = if super_category && super_category.super_category
      'sub_sub_category'
    elsif super_category
      'sub_category'
    else
      'category'
    end
    cls += ' blacklisted' if blacklisted
    cls
  end
  
  def icon_url
    "#{icon_prefix}32#{icon_extension}"
  end
end