class AddOnlineEventBooleanToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :online_event, :boolean, :default => false
  end

  def self.down
  	remove_column :events, :online_event
  end
end
