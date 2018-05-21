class AddLayoutIdToEventCategories < ActiveRecord::Migration
  def self.up
    add_column :event_categories, :event_layout_id, :integer
    add_column :event_categories, :description, :text
  end

  def self.down
    remove_column :event_categories, :event_layout_id
    remove_column :event_categories, :description
  end
end
