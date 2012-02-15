class AddIpLocationFieldsToApiCallLogs < ActiveRecord::Migration
  def change
    add_column :api_call_logs, :ip_city, :string
    add_column :api_call_logs, :ip_country, :string
    add_column :api_call_logs, :ip_lat, :string
    add_column :api_call_logs, :ip_lng, :string
  end
end
