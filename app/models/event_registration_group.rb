class EventRegistrationGroup < PersonGroup
  has_many :event_registrations
  has_many :people, :through => :event_registrations
  belongs_to :owner, :class_name => 'Person'
  belongs_to :event
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :event_registrations
  attr_accessor :event_kind #for spambots
  
  def owner_is_attending?
    self.is_attending
  end
  def subtotal
    prices = 0
    self.event_registrations.each do |e|
      prices += (e.event_transaction.total || 0)
    end
    prices.to_s
  end
  def is_paid?
    self.paid ? "paid" : "not paid"
  end
end
