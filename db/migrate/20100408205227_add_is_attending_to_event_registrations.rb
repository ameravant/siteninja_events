class AddIsAttendingToEventRegistrations < ActiveRecord::Migration
  def self.up
    add_column :event_registrations, :is_attending, :boolean, :default => true
    add_column :event_registrations, :event_price_option_id, :integer
  end

  def self.down
    remove_column :event_registrations, :is_attending
    remove_column :event_registrations, :event_price_option_id
  end
end
