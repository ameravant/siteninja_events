class CreateEventTransactions < ActiveRecord::Migration
  def self.up
    create_table :event_transactions do |t|
      t.integer :event_registration_id
      t.float :total
      t.boolean :card, :cash, :check, :other, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :event_transactions
  end
end

