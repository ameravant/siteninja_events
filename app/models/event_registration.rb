class EventRegistration < ActiveRecord::Base
  belongs_to :event
  belongs_to :person
  has_one :event_transaction # transactions.registration_id

  def payment_method
    if self.card?
      "PayPal"
    elsif self.cash?
      "Cash"
    elsif self.check?
      "Check"
    elsif self.other?
      "Other"
    end
  end

  def is_registered?(email,event_id)
    curr_person = Person.find_by_email(email)
    event = Event.find(event_id)
    event.event_registrations.each do |e|
      if e.person_id == curr_person.id
        return true
      end
    end
    return false
  end

  def calculate_total
    rc = RegistrationPerson.find(:all, :conditions => { :event_registration_id => self.id }, :include => :event_price)
    total = 0.0
    for x in rc
      total += x.event_price.price
    end
    total
  end

  def send_notification_emails
    event = Event.find(self.event_id)
    rcs = RegistrationPerson.find_all_by_event_registration_id(self.id, :include => :people, :order => "people.last_name, people.first_name")
    total = self.calculate_total

    for rc in rcs
      c = rc.person
      if rc.owner? and !c.email.blank?
        # Registration owner
        PostOffice.deliver_event_registration_owner(c, event, self, total, rcs)
      elsif !c.email.blank?
        # Guest with present email address
        registration_owner ||= RegistrationPerson.find_by_event_registration_id_and_owner(self.id, true, :include => :people)
        PostOffice.deliver_event_registration_guest(c.name, c.email, event.permalink, event.title, event.date_and_time, registration_owner.person.name)
      end
    end
  end
end

class Person < ActiveRecord::Base
has_many :event_registrations
end

