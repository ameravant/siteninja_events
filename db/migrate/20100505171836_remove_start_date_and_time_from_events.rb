class RemoveStartDateAndTimeFromEvents < ActiveRecord::Migration
  def self.up
    remove_column :events, :start_date_and_time
  end

  def self.down
    add_column :events, :start_date_and_time, :datetime
  end
end
