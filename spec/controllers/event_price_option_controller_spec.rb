require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
 
describe Admin::EventPriceOptionsController do
  before(:each) do
    @event = Factory(:random_event)
  end
  describe "routing" do
    it "should route to NEW" do
      route_for(:controller => "admin/event_price_options", :action => "new", :event_id => @event.id).should == "/calendar/#{@event.id}-#{@event.permalink}/event_price_options/new"
      new_admin_event_event_price_option(@event).should == "/calendar/#{@event.id}-#{@event.permalink}/event_price_options/new"
    end
  end
  describe "GET 'new'" do
    it "should assign an instance to a new event registration" do
      @event_registration = mock('event_registration')
      EventRegistration.expects(:new).returns(@event_registration)
      get :new, :event_id => @event.id
      assigns[:event_registration].should == @event_registration
    end
  end
  # describe "GET 'index'" do
  #     it "should assign an instance var for all cities" do
  #       cities = threeTimes {Factory(:valid_city)}
  #       controller.stubs(:get_current_city_name_from_ip).returns("Lima")
  #       City.expects(:all).returns(cities)
  #       get 'index'
  #       assigns[:cities].should == cities
  #     end