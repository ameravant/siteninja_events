class AddEventRegistrationGroupIdToEventRegistrations < ActiveRecord::Migration
  def self.up
    unless EventRegistration.new.respond_to?(:event_registration_group_id)
      add_column :event_registrations, :event_registration_group_id, :integer
    end 
  end
    
  def self.down
    if EventRegistration.new.respond_to?(:event_registration_group_id)
      remove_column :event_registrations, :event_registration_group_id
    end
  end
end
