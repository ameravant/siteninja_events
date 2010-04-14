require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventRegistrationGroupsController do
  before(:each) do
    @event = Factory(:random_event)
  end 
  describe "routing" do
    it "should route to NEW" do
      route_for(:controller => "event_registration_groups", :action => "new", :event_id => "#{@event.id}-#{@event.permalink}").should == "/calendar/#{@event.id}-#{@event.permalink}/event_registration_groups/new"
      new_event_event_registration_group_path(@event).should == "/calendar/#{@event.id}-#{@event.permalink}/event_registration_groups/new"
    end
  end
  describe "POST 'create'" do
    it "should " do  
    end
  end
  describe "GET 'new'" do
    before(:each) do
      @event = Factory(:random_event)
    end
    it "should respond to new" do
      get :new, :event_id => @event.id
      response.should render_template(:new)
    end
    it "should assign an instance to a new Event registration group" do
      @event_registration_group = mock('event_registration_group')
      EventRegistrationGroup.expects(:new).returns(@event_registration_group)
      get :new, :event_id => @event.id
      assigns[:event_registration_group].should == @event_registration_group
    end
    it "should assign an instance to a new event registration" do
      @event_registration = mock('event_registration')
      EventRegistration.expects(:new).returns(@event_registration)
      get :new, :event_id => @event.id
      assigns[:event_registration].should == @event_registration
    end
    it "should assign an instance to a new person record" do
      @person = mock('person')
      Person.expects(:new).returns(@person)
      get :new, :event_id => @event.id
      assigns[:person].should == @person
    end  
    it "should assign instance variable to the associated price options" do
      @event_price_options = threeTimes{Factory(:random_event_price_option, :event_id => @event.id)}
      @event.stubs(:event_price_options).returns(@event_price_options)
      get :new, :event_id => @event.id.to_i
      assigns[:event_price_options].should == @event_price_options
    end
  end
  # describe "POST create" do
  #     
  #   end
  #   describe "GET 'show'" do
  #         before(:each) do
  #           find_registration_group
  #         end
  #         it "should find a registration_group" do
  #           get 'show'
  #           assigns[:event_registration_group].should == @event_registration_group
  #           response.should render_template :show
  #         end
  #         it "should get a list of price options for the registration_group" do
  #           price_options = threeTimes{Factory(:random_price_option, :registration_group_id => @registration_group.id, :public => true)}
  #           get 'show'
  #           assigns[:price_options].should == price_options
  #         end
  #       end
  #       private
  #       
  #       def find_registration_group
  #         @event_registration_group = Factory(:random_registration_group)
  #         EventRegistrationGroup.expects(:find_by_permalink).with(params[:id]).returns(@registration_group)
  #       end
end