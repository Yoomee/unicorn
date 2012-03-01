class CreateVenueCategories < ActiveRecord::Migration
  def change
    create_table :venue_categories do |t|
      t.belongs_to :venue
      t.belongs_to :category
      t.boolean :primary
    end
    add_index :venue_categories, [:venue_id, :category_id]
  end
end
