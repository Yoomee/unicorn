class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :text
      t.string :button_text
      t.boolean :button_hidden
      t.integer :repeat_count
      t.timestamps
    end
  end
end
