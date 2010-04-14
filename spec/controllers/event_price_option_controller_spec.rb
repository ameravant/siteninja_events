# require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
# 
# describe PriceOptionsController do

  # describe "routing" do
  #   it "should route to NEW" do
  #     route_for(:controller => "cities", :action => "new").should == "/cities/new"
  #     new_city_path.should == "/cities/new"
  #   end
  #   it "index should map to root" do
  #     route_for(:controller => "cities", :action => "index").should == root_path
  #     route_for(:controller => "cities", :action => "index").should.should == "/"
  #   end
  # end
  # describe "GET 'index'" do
  #     it "should assign an instance var for all cities" do
  #       cities = threeTimes {Factory(:valid_city)}
  #       controller.stubs(:get_current_city_name_from_ip).returns("Lima")
  #       City.expects(:all).returns(cities)
  #       get 'index'
  #       assigns[:cities].should == cities
  #     end