class CreateEventCategories < ActiveRecord::Migration
  def self.up
    create_table :event_categories, :force => true do |t|
      t.string :title
      t.string :permalink
      t.integer :menus_count, :images_count, :features_count, :default => 0
      t.boolean :active, :default => true
      t.integer :sort_order
    end
  end

  def self.down
    drop_table :event_categories
  end
end
