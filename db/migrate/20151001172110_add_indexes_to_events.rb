class AddIndexesToEvents < ActiveRecord::Migration
  def self.up
  	add_index :events, :person_id
  	add_index :events, :event_category_id
  	add_index :event_categories, :column_id
  	add_index :event_categories, :main_column_id
  end

  def self.down
  	remove_index :events, :person_id
  	remove_index :events, :event_category_id
  	remove_index :event_categories, :column_id
  	remove_index :event_categories, :main_column_id
  end
end
