require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
describe Event do
  describe "associations" do
    it "should have many price options" do
      event = Factory(:random_event)
      price_opt = Factory(:random_price_option, :event_id => event.id)
      price_opt2 = Factory(:random_price_option, :event_id => event.id)
      price_opt3 = Factory(:random_price_option, :event_id => event.id + 1)
      event.price_options.should == [price_opt, price_opt2]
      event.price_options.should_not include price_opt3      
    end
  end
  describe "scopes" do
    before(:each) do
      @events = threeTimes{Factory(:random_event)}
    end
  end
end