class CreateTicketStatuses < ActiveRecord::Migration
  def change
    create_table :ticket_statuses do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index :ticket_statuses, :name, :unique => true
  end
end
