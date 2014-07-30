class AddRestrictLinkToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :restrict_link, :boolean, :default => false
  end

  def self.down
  	remove_column :events, :restrict_link
  end
end
