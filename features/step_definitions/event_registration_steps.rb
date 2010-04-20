Given /^there is an event titled "([^\"]*)"$/ do |name|
  Factory(:random_event, :name => name)
end

Given /^there is a public group named "([^\"]*)"$/ do |name|
  Factory(:random_public_group, :title => name)
end

Given /^I am not attending "([^\"]*)"$/ do |name|
  Factory(:random_registration_group, :event_id => Event.find_by_name(name).id, :is_attending => false)
end
Given /^there is an event registration group for "([^\"]*)" titled "([^\"]*)"$/ do |event_name, title|
  Factory(:random_registration_group, :title => title, :event_id => Event.find_by_name(event_name).id)
end


Then /^I should see fields labeled (.+)$/ do |labels|
  labels.split(', ').each do |label|
    if defined?(Spec::Rails::Matchers)
      response.should contain(label)
    else
      assert_contain label
    end
  end
end
Given /^I am logged in as admin$/ do
  visit new_session_url
  fill_in "Login", :with => "admin"
  fill_in "Password", :with => "admin"
  click_button "Sign in" 
end


