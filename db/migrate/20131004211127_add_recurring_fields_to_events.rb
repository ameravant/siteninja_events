class AddRecurringFieldsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :monday, :boolean
    add_column :events, :tuesday, :boolean
    add_column :events, :wednesday, :boolean
    add_column :events, :thursday, :boolean
    add_column :events, :friday, :boolean
    add_column :events, :saturday, :boolean
    add_column :events, :sunday, :boolean
    add_column :events, :holiday, :boolean
    add_column :events, :repeat_start_date, :date
    add_column :events, :repeat_end_date, :date
    add_column :events, :event_id, :integer
    add_column :events, :repeat, :boolean, :default => false
    add_column :events, :repeat_frequency, :string, :default => "weekly"
    add_column :events, :repeat_every, :integer, :default => 1
    add_column :events, :repeat_by, :string
    add_column :events, :repeat_start_time, :time
    add_column :events, :repeat_end_time, :time
    add_column :events, :week_1, :boolean
    add_column :events, :week_2, :boolean
    add_column :events, :week_3, :boolean
    add_column :events, :week_4, :boolean
    add_column :events, :week_5, :boolean
    add_column :events, :week_last, :boolean
    add_column :events, :month_day, :integer
  end

  def self.down
    remove_column :events, :repeat
    remove_column :events, :month_day
    remove_column :events, :week_last
    remove_column :events, :week_1
    remove_column :events, :week_2
    remove_column :events, :week_3
    remove_column :events, :week_4
    remove_column :events, :week_5
    remove_column :events, :repeat_end_time
    remove_column :events, :repeat_start_time
    remove_column :events, :repeat_every
    remove_column :events, :repeat_by
    remove_column :events, :repeat_frequency
    remove_column :events, :event_id
    remove_column :events, :repeat_end_date
    remove_column :events, :repeat_start_date
    remove_column :events, :holiday
    remove_column :events, :sunday
    remove_column :events, :saturday
    remove_column :events, :friday
    remove_column :events, :thursday
    remove_column :events, :wednesday
    remove_column :events, :tuesday
    remove_column :events, :monday
  end
end