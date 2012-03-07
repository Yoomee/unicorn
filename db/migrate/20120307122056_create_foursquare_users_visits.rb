class CreateFoursquareUsersVisits < ActiveRecord::Migration
  def change
    create_table :foursquare_users_visits, :id => false do |t|
      t.belongs_to :foursquare_user
      t.belongs_to :visit
    end
    add_index :foursquare_users_visits, :foursquare_user_id
    add_index :foursquare_users_visits, :visit_id
  end
end
