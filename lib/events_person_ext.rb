module EventsPersonExt

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods

    def events_person_extra_methods
      has_many :event_registrations
      has_many :event_registration_groups, :through => :event_registrations
      validates_presence_of :first_name, :last_name, :email

      include EventsPersonExt::InstanceMethods
    end
  end

  module InstanceMethods
    def registration_group_for(event)
      #PersonGroup.all(:conditions => {:event_id => event.id})
      self.event_registration_groups.find(:first, :conditions => "person_groups.event_id = #{event.id}")
      # self.event_registration_groups.find(:first, :conditions => "person_groups.event_id = #{event.id}")
    end
    def admin?
      respond_to?(:user) && user.is_admin
    end
    def full_name
      first_name + ' ' + last_name
    end
  end

end
ActiveRecord::Base.send(:include, EventsPersonExt)
Person.send(:events_person_extra_methods)
#Person.extend(EventsPersonExt::ClassMethods)