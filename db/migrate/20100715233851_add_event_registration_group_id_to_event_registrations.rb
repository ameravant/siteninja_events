class AddEventRegistrationGroupIdToEventRegistrations < ActiveRecord::Migration
  unless EventRegistration.new.respond_to?(:event_registration_group_id)
    def self.up
      add_column :event_registrations, :event_registration_group_id, :integer
    end
    
    def self.down
      remove_column :event_registrations, :event_registration_group_id
    end
  end
end
