class EventRegistrationGroup < PersonGroup
  has_many :event_registrations
  has_many :people, :through => :event_registrations
end