class AddCheckInstructionsToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :check_instructions, :text
  end

  def self.down
    remove_column :events, :check_instructions
  end
end
