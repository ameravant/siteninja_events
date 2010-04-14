class EventPriceOption < ActiveRecord::Base
  belongs_to :event
  has_many :event_registrations
  named_scope :public, :conditions => ["public = ?", true]
end