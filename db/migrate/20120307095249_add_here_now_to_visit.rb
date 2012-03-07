class AddHereNowToVisit < ActiveRecord::Migration
  def change
    add_column :visits, :here_now, :integer
  end
end
