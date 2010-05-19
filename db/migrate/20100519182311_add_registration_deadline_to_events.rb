class AddRegistrationDeadlineToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :registration_deadline, :datetime
  end

  def self.down
    remove_column :events, :registration_deadline
  end
end
