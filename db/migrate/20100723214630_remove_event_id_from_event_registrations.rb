class RemoveEventIdFromEventRegistrations < ActiveRecord::Migration
  def self.up
    if EventRegistration.new.respond_to?(:event_id)
      remove_column :event_registrations, :event_id
    end
  end
  def self.down
    unless EventRegistration.new.respond_to?(:event_id)
      add_column :event_registrations, :event_id, :integer
    end
  end
end
