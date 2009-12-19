class EventPrice < ActiveRecord::Base
  belongs_to :event
  validates_presence_of :event_price
  validates_numericality_of :event_price, :allow_blank => true
end

