class AddMainColumnIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :event_categories, :main_column_id, :integer
  end

  def self.down
    remove_column :event_categories, :main_column_id
  end
end