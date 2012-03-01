class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :fsid
      t.string :name
      t.string :plural_name
      t.string :short_name
      t.string :icon_prefix
      t.string :icon_extension
    end
    add_index :categories, :fsid
  end
end