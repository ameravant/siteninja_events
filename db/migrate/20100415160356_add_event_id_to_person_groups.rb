class AddEventIdToPersonGroups < ActiveRecord::Migration
  def self.up
    add_column :person_groups, :event_id, :integer
    add_column :person_groups, :owner_id, :integer
    add_column :person_groups, :is_attending, :boolean, :default => true
  end

  def self.down
    remove_column :person_groups, :event_id
    remove_column :person_groups, :owner_id
    remove_column :person_groups, :is_attending
  end
end
