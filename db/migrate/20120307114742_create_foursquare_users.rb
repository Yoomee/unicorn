class CreateFoursquareUsers < ActiveRecord::Migration
  def change
    create_table :foursquare_users do |t|
      t.integer :fsid
      t.string :first_name
      t.string :last_name
      t.string :photo
      t.string :gender
      t.string :home_city
      t.string :canonical_url
    end    
  end
end
