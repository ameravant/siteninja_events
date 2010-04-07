# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# 
# describe EventRegistration do
#   before(:each) do
#     @valid_attributes = {
#       :name => "New Event"
#     }
#   end
#   it "should create a new instance given valid attributes" do
#     EventRegistration.create!(@valid_attributes)
#   end
#    it "should create a permalink" do
#     event = EventRegistration.create!(:name => "Foxboro")
#     event.permalink.should == "foxboro"
#     event.update_attributes(:name => "Mansfield")
#     event.permalink.should == "foxboro"
#     event.name.should == "Mansfield"
#   end
# end