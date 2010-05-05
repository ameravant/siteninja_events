class EventTransaction < ActiveRecord::Base
  belongs_to :event_registration
  
  def pay_method
    self.event_registration.event_registration_group.pay_method
  end
end
