class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.string :name,       :null => false
      t.string :email,      :null => false
      t.string :department, :null => false
      t.string :subject,    :null => false
      t.text   :message,    :null => false
      t.string :no
      t.string :url
      t.references :owner
      t.references :status

      t.timestamps
    end

    add_index :tickets, :owner_id
    add_index :tickets, :status_id
    add_index :tickets, :no, :unique => true
    add_index :tickets, :subject
  end
end
