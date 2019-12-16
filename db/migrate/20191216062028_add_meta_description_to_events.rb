class AddMetaDescriptionToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :meta_description, :text
  end

  def self.down
  	remove_column :events, :meta_description
  end
end
