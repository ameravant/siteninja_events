class AddLayoutIdToEventCategories < ActiveRecord::Migration
  def self.up
    add_column :event_categories, :event_layout_id, :integer
  end

  def self.down
    remove_column :event_categories, :event_layout_id
  end
end
