class AddPaidToPersonGroups < ActiveRecord::Migration
  def self.up
    add_column :person_groups, :paid, :boolean
  end

  def self.down
    remove_column :person_groups, :paid
  end
end
