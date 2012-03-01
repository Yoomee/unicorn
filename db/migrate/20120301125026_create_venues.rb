class CreateVenues < ActiveRecord::Migration
  def change
    create_table :venues do |t|
      t.string :fsid
      t.string :name
      t.string :address
      t.string :postal_code
      t.string :city
      t.string :state
      t.string :country
      t.string :lat
      t.string :lng
      t.boolean :verified
      t.integer :checkins_count
      t.integer :users_count
      t.integer :tip_count
      t.integer :here_now
      t.timestamps
    end
    add_index :venues, :fsid
  end
end
