require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EventRegistrationGroup do
  before(:each) do
    @event = Factory(:random_event)
    @owner = Factory(:random_person)
    @valid_attributes = {
      :title => "jason's group",
      :event_id => @event.id,
      :public => true,
      :owner_id => @owner.id,
      :is_attending => true,
      :type => "EventRegistrationGroup"
    }
  end

  it "should create a new instance given valid attributes" do
    EventRegistrationGroup.create!(@valid_attributes)
  end
  it "should be a person group" do
    EventRegistrationGroup.any_instance.is_a?(PersonGroup).should == true
  end
  it "should calculate a total" do
    @owner = Factory(:random_person)
    @guests = threeTimes{Factory(:random_person)}
    @event_group = Factory(:random_registration_group, 
                           :event_id => @event.id, 
                           :owner_id => @owner.id
                           )
    @price_options = threeTimes{Factory(:random_price_option)}
    @guests.each_with_index do |g, i| 
      Factory(:random_event_registration, 
              :event_group_id => @event_group.id,
              :person_id => g.id,
              :price_option_id => @price_options[i]
              )}
    end
    @event_group.total.should == @price_options.sum{|p| p.price }
  end
end