class AddFieldsToEventTransactions < ActiveRecord::Migration
  def self.up
    add_column :event_transactions, :description, :text
    add_column :event_transactions, :title, :string
  end

  def self.down
    remove_column :event_transactions, :title
    remove_column :event_transactions, :description
  end
end
