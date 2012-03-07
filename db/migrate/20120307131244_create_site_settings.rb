class CreateSiteSettings < ActiveRecord::Migration
  def change
    create_table :site_settings do |t|
      t.string :name
      t.string :value
    end
    add_index :site_settings, :name
  end
end
