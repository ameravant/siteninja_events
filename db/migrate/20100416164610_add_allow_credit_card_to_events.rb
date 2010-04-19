class AddAllowCreditCardToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :allow_credit_card, :boolean
  end

  def self.down
    remove_column :events, :allow_credit_card
  end
end
