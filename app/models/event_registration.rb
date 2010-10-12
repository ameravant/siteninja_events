class EventRegistration < ActiveRecord::Base
  belongs_to :event_registration_group
  belongs_to :person
  validates_presence_of :person_id
  after_create :add_person_to_master_group
  # accepts_nested_attributes_for :person
  belongs_to :event_price_option
  has_one :event_transaction # transactions.registration_id
  attr_accessor :event_kind #for spambots
  
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
  def event
    self.event_registration_group.event
  end
  
  def paid?
    self.event_registration_group.paid ? "paid" : "not paid"
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
  private
  def add_person_to_master_group
    if self.event.master_group_id.nil?
      group = PersonGroup.find_or_create_by_title("#{self.event.title}-master-#{self.event.date_and_time.strftime('%b-%d-%y')}", :public => false, :role => false)
      if !group.public
        group.public = false
        group.role  = false
        group.save
      end
      self.event.master_group_id = group.id
      self.event.save
    else
      group = self.event.master_group
    end
    self.person.person_group_ids = self.person.person_group_ids << group.id unless self.person.person_group_ids.include?(group.id)
    self.person.save
  end
end


