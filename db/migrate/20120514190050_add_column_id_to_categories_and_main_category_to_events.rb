class AddColumnIdToCategoriesAndMainCategoryToEvents < ActiveRecord::Migration
  def self.up
    add_column :event_categories, :column_id, :integer
    add_column :events, :event_category_id, :integer
  end

  def self.down
    remove_column :events, :event_category_id
    remove_column :event_categories, :column_id
  end
end