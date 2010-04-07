class CreatePriceOptions < ActiveRecord::Migration
  def self.up
    create_table :price_options do |t|
      t.string :title, :description
      t.integer :event_id, :price
      t.boolean :public
      t.timestamps
    end
  end

  def self.down
    drop_table :price_options
  end
end
