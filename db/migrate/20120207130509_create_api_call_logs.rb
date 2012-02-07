class CreateApiCallLogs < ActiveRecord::Migration
  def change
    create_table :api_call_logs do |t|
      t.belongs_to :app_user
      t.string :app_version
      t.integer :message_id
      t.string :lat
      t.string :lng
      t.string :ip_address
      t.timestamps
    end
  end
end
