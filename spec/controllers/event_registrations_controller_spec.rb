require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventRegistrationsController do
  before(:each) do
    @event = Factory(:random_event)
    @event_registration_group = Factory(:random_registration_group, :event_id => @event.id)
  end
  it "should route to a new event registration if there's an event" do
    
  end
  it "should not route to a new event without an event" do
    
  end
  describe "GET 'new'" do
    before(:each) do
      @event_price_options = threeTimes{Factory(:random_event_price_option, :event_id => @event.id)}
    end
    it "should assign an instance variable to the event" do
      Event.expects(:find).with(params[:event_id]).returns(@event)
      get :new, :event_id => @event.id, :event_registration_group_id => @event_registration_group.id
      assigns[:event].should == @event
    end
    it "should assign an instance variable to a new event registration record" do
      @event_registration = mock('event_registration')
      EventRegistration.expects(:new).returns(@event_registration)
      get :new, :event_id => @event.id, :event_registration_group_id => @event_registration_group.id
      assigns[:event_registration].should == @event_registration
    end
    it "should assign instance variable to the associated price options" do
      @event.stubs(:event_price_options).returns(@event_price_options)
      get :new, :event_id => @event.id, :event_registration_group_id => @event_registration_group.id
      assigns[:event_price_options].should == @event_price_options
    end
    it "should find all existing guests and assign an instance variable" do
      valid_people = threeTimes{Factory(:random_person)}
      @current_guests = valid_people.collect{|p| Factory(:event_registration, :event_registration_group_id => @event_registration_group.id, :person_id => p.id, :event_price_option_id => @event_price_options.first.id)}
      @event_registration.stubs("people").returns(@current_guests)
      get :new, :event_id => @event.id, :event_registration_group_id => @event_registration_group.id
      assigns[:current_guests].should == @current_guests
    end
  end 
end