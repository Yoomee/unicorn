class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.belongs_to :venue
      t.datetime :arrived_at
    end
    add_index :visits, :venue_id
  end
end
