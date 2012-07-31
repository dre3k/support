class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name,  :null => false
      t.string :email, :null => false

      t.timestamps
    end

    add_index :customers, :email, :unique => true
  end
end
