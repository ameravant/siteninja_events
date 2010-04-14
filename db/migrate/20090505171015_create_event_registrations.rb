class CreateEventRegistrations < ActiveRecord::Migration
  def self.up
    create_table :event_registrations do |t|
      t.integer :event_registration_group_id, :person_id, :null => false
      t.boolean :approved, :default => false
      t.text :comments
      t.timestamps
    end
  end

  def self.down
    drop_table :event_registrations
  end
end

