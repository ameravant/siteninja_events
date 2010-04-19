require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventRegistration do
  before(:each) do
    @event = Factory(:random_event)
    @event_price_option = Factory(:random_event_price_option)
    @event_registration_group = Factory(:random_registration_group, :event_id => @event.id)
    @person = Factory(:random_person)
    @valid_attributes = {
      :event_registration_group_id => @event_registration_group.id,
      :event_price_option_id => @event_price_option.id,
      :person_id => @person.id
    }
  end
  it "should create a new instance given valid attributes" do
    EventRegistration.create!(@valid_attributes)
  end
  it "should be associated to a price option" do
    new_registration = Factory(:event_registration, @valid_attributes)
    new_registration.event.should == @event
    new_registration.person.should == @person
    new_registration.event_price_option.should == @event_price_option
    @person.event_registrations.include?(new_registration).should == true
  end
end