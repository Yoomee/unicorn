class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.belongs_to :venue
      t.text :text
      t.datetime :starts_at
      t.datetime :ends_at
      t.timestamps
    end
  end
end
