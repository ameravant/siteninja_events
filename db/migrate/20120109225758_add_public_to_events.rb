class AddPublicToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :active, :boolean, :default => true
  end

  def self.down
    remove_column :events, :active
  end
end