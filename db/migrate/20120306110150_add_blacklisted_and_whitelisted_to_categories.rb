class AddBlacklistedAndWhitelistedToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :blacklisted, :boolean, :default => false
    add_column :categories, :whitelisted, :boolean, :default => false
  end
end
