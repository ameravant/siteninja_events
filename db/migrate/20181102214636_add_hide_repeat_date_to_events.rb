class AddHideRepeatDateToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :display_repeat_start_date, :boolean, :default => true
  	add_column :events, :display_repeat_end_date, :boolean, :default => true
  end

  def self.down
  	remove_column :events, :display_repeat_start_date
  	remove_column :events, :display_repeat_end_date
  end
end
