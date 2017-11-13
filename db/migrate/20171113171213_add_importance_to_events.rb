class AddImportanceToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :importance, :string, :default => "Small" 
  end

  def self.down
  	remove_column :events, :importance
  end
end
