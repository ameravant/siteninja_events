class CreateEventCategoriesEvents < ActiveRecord::Migration
  def self.up
    create_table :event_categories_events,:id => false do |t|
      t.integer :event_id
      t.integer :event_category_id
    end
  end

  def self.down
    drop_table :event_categories_events
  end
end
