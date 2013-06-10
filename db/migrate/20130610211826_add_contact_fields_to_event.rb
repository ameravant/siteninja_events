class AddContactFieldsToEvent < ActiveRecord::Migration
  def self.up
    add_column :events, :person_name, :string
    add_column :events, :person_email, :string
  end

  def self.down
    remove_column :events, :person_email
    remove_column :events, :person_name
  end
end