class AddMasterGroupIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :master_group_id, :integer
  end

  def self.down
    remove_column :events, :master_group_id
  end
end
