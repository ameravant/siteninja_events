Feature: registering for an event
  In order to go to an event
  As an anonymous user
  I want to register
Background:
  Given the following random_event records
  | name      | date_and_time                  | id  |
  | new event | Fri Aug 14 14:57:19 -0700 2011 | 200 |
  Given there is a public group named "new group"
  Given the following price_option records
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
  And I should see fields labeled First name, Last name, Email, Phone, Business Phone, Company, Title, Address1, Address2, City, Zip Code, Comments 
  And I should see "new group" 
  When I fill in the following:
  | First name     | jason           |
  | Last name      | Gagne           |
  | Email          | test@test.com   |
  | Phone          | 123-234-2344    |
  | Business Phone | business_name   |
  | Company        | company_name    |
  | Title          | title           |
  | Address        | 123 test street |
  | Address2       | apt 12          |
  | City           | Santa Barbara   |
  | Zip Code       | 93150           |
  And I select "volunteer" from "Guest Type"
  And I check "new group"
  And I press "Save and continue"
  Then I should be on the new_event_registration_group_registration page for "new event" and "1-new-event-registration-group"
  And I should see "Add a guest"
  And I should see "Checkout?"
  And I should see "Pay by check"
  And I should see "Pay by cash at the event"
  And I should see "Pay with a credit card"
  And I should see "Guest List"
  And I should see "Jason Gagne"
  And I should see "Total: $10"
  
  
  
  


