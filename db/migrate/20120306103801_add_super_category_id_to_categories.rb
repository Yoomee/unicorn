class AddSuperCategoryIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :super_category_id, :integer
    add_index :categories, :super_category_id
  end
end
