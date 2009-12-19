class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
    t.string :name, :permalink, :address
    t.text :description
    t.datetime :date_and_time
    t.integer :person_id
    t.integer :images_count, :features_count, :assets_count, :default => 0

    # Registration-specific fields
    t.integer :registration_limit
    t.text :payment_instructions, :registration_closed_text, :blurb
    t.boolean :registration, :allow_cash, :allow_check, :allow_other, :default => false
    t.boolean :allow_card, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end

