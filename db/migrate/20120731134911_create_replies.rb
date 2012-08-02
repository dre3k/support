class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :replier_id
      t.integer :owner_from_id
      t.integer :owner_to_id
      t.integer :status_from_id
      t.integer :status_to_id
      t.text :message,       :null => false

      t.timestamps
    end
  end
end
