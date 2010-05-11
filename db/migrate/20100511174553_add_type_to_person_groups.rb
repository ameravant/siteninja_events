class AddTypeToPersonGroups < ActiveRecord::Migration
  def self.up
    add_column :person_groups, :type, :string
  end

  def self.down
    remove_column :person_groups, :type
  end
end
