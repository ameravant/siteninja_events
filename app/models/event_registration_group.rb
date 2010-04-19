class EventRegistrationGroup < PersonGroup
  has_many :event_registrations
  has_many :people, :through => :event_registrations
  belongs_to :owner, :class_name => 'Person'
  belongs_to :event
  accepts_nested_attributes_for :people
  accepts_nested_attributes_for :event_registrations
  
  def owner_is_attending?
    self.is_attending
  end
  def subtotal
    prices = 0
    self.event_registrations.reject{|r| r.event_price_option_id.nil?}.each do |e|
      prices += EventPriceOption.find(e.event_price_option_id).price
    end
    prices.to_s
  end
end