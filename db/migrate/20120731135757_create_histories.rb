class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.integer :ticket_id, :null => false
      t.integer :reply_id,  :null => false

      t.timestamps
    end

    add_index :histories, :ticket_id
  end
end
