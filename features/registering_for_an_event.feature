@public
Feature: registering for an event
  In order to go to an event
  As an anonymous user
  I want to register
Background:
  Given the following random_event records
  | name      | date_and_time            | id  |
  | new event | Fri Aug 14 14:57:19 -0700 2011 | 200 |
  Given there is a public group named "new group"
  Given the following event_price_option records
  | title     | description                     | price | public | event_id |
  | volunteer | for volunteers                  | 5     | true   | 200      |
  | artist    | for artists only                | 10    | true   | 200      |
  | supporter | for members of our support team | 10    | true   | 200      |
  | private   | for private people              | 20    | false  | 200      |
  
Scenario: going to the event page
  Given I am on the homepage
  Then I should see "new event"
  When I follow "new event"
  Then I should be on the event page for "new event"
  
Scenario: browsing the event page
  When I go to the event page for "new event"
  Then I should see "Pricing Options"
  And I should see "volunteer"
  And I should see "for volunteers"
  And I should see "artist"
  And I should see "for artists only"
  And I should see "supporter"
  And I should see "for members of our support team"
  And I should see "$5"
  And I should see "$10"
  And I should not see "private"
  And I should not see "for private people"
  And I should not see "$20"
  And I should see "You may pay by:"
  And I should see "Register Now"

Scenario: going to the new registration page
  Given I am on the event page for "new event"
  When I follow "Register Now" 
  Then I should be on the new registration_group page for "new event" 
  And I should see "Register for 'new event'"
  And I should see fields labeled First name, Last name, Email, Phone, Company, Title, Address1, Address2, City, Zip, Comments 
  When I fill in the following:
  | First name     | Jason           |
  | Last name      | Gagne           |
  | Email          | test@test.com   |
  | Phone          | 123-234-2344    |
  | Company        | company_name    |
  | Title          | title           |
  | Address1       | 123 test street |
  | Address2       | apt 12          |
  | City           | Santa Barbara   |
  | Zip            | 93150           |
  And I select "volunteer" from "Guest Type"
  And I check "event_registration_group_is_attending"
  And I press "Save and continue"
  Then I should be on the new event registration group registration page for "new event" and "Jason Gagne's Group For New Event"
  And I should see "Add a guest"
  And I should see "Checkout?"
  And I should see "Pay by check"
  And I should see "Pay by cash"
  And I should see "Pay by credit-card"
  And I should see "Guest List"
  And I should see "Jason Gagne"
  And I should see "Total: $5"
  # passing to here.
  
@checkout  
Scenario: adding a guest and paying for the event
  Given the following person records
  | email             | first_name | last_name |
  | sample@sample.com | Jason      | Gagne     |
  And there is an event registration group for "new event" titled "Jason's group for new event"
  And I am not attending "new event"
  When I go to the add a guest page for "Jason's group for new event"
  Then I should not see "Jason Gagne"
  And I should not see "total"
  And I should see "Add a guest?"
  When I fill in the following:
   | First Name   | Samplefirst      |
   | Last Name    | Samplelast       |
   | Email        | Sample@sample2.com |
   | Phone Number | 123-435-0988      |
  And I select "volunteer" from "Guest Type"
  And I press "Save and Continue"
  # Then I should see "jasodfafd"
  Then I should be on the add a guest page for "Jason's group for new event"
  And I should see "Samplefirst"
  And I should see "Total: $5"
  When I fill in the following:
   | First Name   | bill              |
   | Last Name    | Samplelast       |
   | Email        | sample1@sample.com |
   | Phone Number | 123-435-0988      |
  And I select "artist" from "Guest Type" 
  And I press "Save and Continue"
  Then I should be on the add a guest page for "Jason's group for new event"
  And I should see "bill"
  And I should see "Samplefirst"
  And I should see "Total: $15"
  When I follow "Pay by cash"
  Then I should be on the event registration group page titled "Jason's group for new event" for the event named "new event"
  And I should see "pay by cash"
  And I should not see "pay by check"
  And I should not see "pay by credit-card"
  When I follow "Change your payment method?"
  When I go to the add a guest page for "Jason's group for new event"
  And I should see "Pay by check"
  When I follow "Pay by check"
  Then I should be on the event registration group page titled "Jason's group for new event" for the event named "new event"
  When I follow "Change your payment method?"
  When I go to the add a guest page for "Jason's group for new event"
  When I follow "Pay by credit-card"
  Then I should be on the event registration group page titled "Jason's group for new event" for the event named "new event"
  And I should see "Checkout with Google"
  When I follow "Change your payment method?"
  When I go to the add a guest page for "Jason's group for new event"
  


  
  
  
  


