class AddFieldsToPersonGroups < ActiveRecord::Migration
  def self.up
    add_column :person_groups, :total_price, :integer
    add_column :person_groups, :pay_method, :string
  end

  def self.down
    remove_column :person_groups, :pay_method
    remove_column :person_groups, :total_price
  end
end
