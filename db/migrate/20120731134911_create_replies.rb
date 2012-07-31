class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.integer :owner_from
      t.integer :owner_to
      t.integer :status_from
      t.integer :status_to
      t.text :message,       :null => false

      t.timestamps
    end
  end
end
