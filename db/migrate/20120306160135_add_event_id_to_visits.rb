class AddEventIdToVisits < ActiveRecord::Migration
  def change
    add_column :visits, :event_id, :integer
  end
end
