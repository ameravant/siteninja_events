class Transaction < ActiveRecord::Base
  belongs_to :event_registration
end
