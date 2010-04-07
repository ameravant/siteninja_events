Given /^there is an event titled "([^\"]*)"$/ do |name|
  Factory(:random_event, :name => name)
end

Given /^there is a public group named "([^\"]*)"$/ do |name|
  Factory(:random_public_group, :title => name)
end

Given /^the following price option records$/ do |table|
  # table is a Cucumber::Ast::Table
  pending # express the regexp above with the code you wish you had
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


