require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PriceOption do
  before(:each) do
    @valid_attributes = {
      :title => "professional",
      :price => "5",
      :description => "for professionals",
      :public => true
    }
  end

  it "should create a new instance given valid attributes" do
    PriceOption.create!(@valid_attributes)
  end
end