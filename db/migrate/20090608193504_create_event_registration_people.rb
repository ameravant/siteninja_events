class CreateEventRegistrationPeople < ActiveRecord::Migration
 def self.up
    create_table :event_registration_people do |t|
      t.integer :person_id, :event_registration_id, :event_price_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :event_registration_people
  end

end

