class AddSeparateDateAndTimeFieldsToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :start_date, :date
  	add_column :events, :start_time, :time
  	add_column :events, :end_date, :date
  	add_column :events, :end_time, :time
	add_column :events, :start_time_string, :string
    add_column :events, :end_time_string, :string
  	add_column :event_categories, :meta_robots, :string
  end

  def self.down
  	remove_column :events, :start_date
  	remove_column :events, :start_time
  	remove_column :events, :end_date
  	remove_column :events, :end_time
  	remove_column :events, :start_time_string, :string
    remove_column :events, :end_time_string, :string
  	remove_column :event_categories, :meta_robots
  end
end
