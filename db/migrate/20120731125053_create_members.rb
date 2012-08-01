class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :name,            :null => false
      t.string :username,        :null => false
      t.string :password_digest, :null => false

      t.timestamps
    end

    add_index :members, :username, :unique => true
  end
end
