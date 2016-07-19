class AddRepeatTimeStringsToEvents < ActiveRecord::Migration
  def self.up
  	add_column :events, :repeat_start_time_string, :string
    add_column :events, :repeat_end_time_string, :string
  end

  def self.down
  	remove_column :events, :repeat_start_time_string, :string
    remove_column :events, :repeat_end_time_string, :string
  end
end
