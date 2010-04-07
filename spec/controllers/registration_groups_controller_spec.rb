require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe RegistrationGroupsController do
  before(:each) do
    @event = Factory(:random_event)
  end 
  describe "routing" do
    it "should route to NEW" do
      route_for(:controller => "registration_groups", :action => "new", :event_id => @event.id).should == "events/#{@event.permalink}/registration_groups/new"
      new_event_registration_group_path.should == "events/#{@event.permalink}/registration_group/new"
    end
    # it "index should map to root" do
    #       route_for(:controller => "cities", :action => "index").should == root_path
    #       route_for(:controller => "cities", :action => "index").should.should == "/"
    #     end
  end
  describe "GET 'show'" do
    before(:each) do
      find_registration_group
    end
    it "should find a registration_group" do
      get 'show'
      assigns[:registration_group].should == @registration_group
      response.should render_template :show
    end
    it "should get a list of price options for the registration_group" do
      price_options = threeTimes{Factory(:random_price_option, :registration_group_id => @registration_group.id, :public => true)}
      get 'show'
      assigns[:price_options].should == price_options
    end
  end
  private
  
  def find_registration_group
    @registration_group = Factory(:random_registration_group)
    RegistrationGroup.expects(:find_by_permalink).with(params[:id]).returns(@registration_group)
  end
end