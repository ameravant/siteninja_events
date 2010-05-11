class RemovePriceOptionIdFromEventRegistrations < ActiveRecord::Migration
  def self.up
    remove_column :event_registrations, :event_price_option_id
  end

  def self.down
    add_column :event_registrations, :event_price_option_id, :integer
  end
end
