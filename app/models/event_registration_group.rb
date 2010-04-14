class EventRegistrationGroup < PersonGroup
  has_many :event_registrations
  has_many :people, :through => :event_registrations
  belongs_to :person
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :event_registrations
end