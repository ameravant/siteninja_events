class CreateEventPrices < ActiveRecord::Migration
  def self.up
    create_table :event_prices do |t|
      t.integer :event_id
      t.string :description
      t.float :price, :default => 0
      t.boolean :active, :default => false
      t.timestamps
    end
  end

  def self.down
    drop_table :event_prices
  end
end

