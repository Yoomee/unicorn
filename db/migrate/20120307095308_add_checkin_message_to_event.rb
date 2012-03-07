class AddCheckinMessageToEvent < ActiveRecord::Migration
  def change
    add_column :events, :checkin_message, :string
  end
end
