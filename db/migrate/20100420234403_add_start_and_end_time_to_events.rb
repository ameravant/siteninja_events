class AddStartAndEndTimeToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :start_date_and_time, :datetime
    add_column :events, :end_date_and_time, :datetime
  end

  def self.down
    remove_column :events, :end_date_and_time
    remove_column :events, :start_date_and_time
  end
end
