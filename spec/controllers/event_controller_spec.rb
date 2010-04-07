require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventsController do 
  describe "GET 'show'" do
    before(:each) do
      find_event
    end
    it "should find a event" do
      get 'show'
      assigns[:event].should == @event
      response.should render_template :show
    end
    it "should get a list of price options for the event" do
      price_options = threeTimes{Factory(:random_price_option, :event_id => @event.id, :public => true)}
      get 'show'
      assigns[:price_options].should == price_options
    end
  end
  private
  
  def find_event
    @event = Factory(:random_event)
    Event.expects(:find_by_permalink).with(params[:id]).returns(@event)
  end
end