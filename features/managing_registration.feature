@admin
Feature: Managing advanced registration
  In order to manage registration
  As an administrator
  I want to add and edit events, price options and rosters
  
  Background:
  Given I am logged in as admin

  Scenario: creating a new event
    Given I am on the admin event index page
    Then I should see "Add a new Event"
    When I follow "Add a new Event"
    Then I should be on the new event page
    And I should see "Add Event"
    And I should see "Registration Required"
    #   js behavior
    #   When I check "registration required"
    #   Then I should see "registration limit"
    #   And I should see "price"
    #   Then I should see "payment options"
    #   And I should see checkboxes for "google", "cod", "check"
    #   When I check "Check option"
    #   Then I should see an html field for 'check instructions'
    And I should see "Registration Limit"
    And I should see fields labeled Name, Address, Message to display when registration is full and closed:, Check Instructions, Event Start date/time, Event End date/time, Price, Description, Registration Limit, Blurb
    When I fill in the following:
     | Name                                                     | brand new event                        |
     | Message to display when registration is full and closed: | Sorry registration closed              |
     | Check Instructions                                       | mail us a check                        |
     | Price                                                    | 10.00                                  |
     | Description                                              | This is gonna be a great event         |
     | Address                                                  | 100 test avenue, testville, test 00000 |
     | Registration Limit                                       | 500                                    |
    And I check "Registration Required"
    And I check "Allow credit card payment"
    And I check "Allow cash payment"
    And I check "Allow check payment"
    And I select "February 20, 2011 08:00" as the "Event Start date/time" date and time
    And I select "February 21, 2011 09:00" as the "Event End date/time" date and time
    And I press "Save Event"
    Then I should be on the new event price option page for "brand new event"
    And I should see "Event created, would you like to add price options"
    And I should see "Current Price Options"
    And I should see "Standard"
    And I should see "$10.00"

  Scenario: adding price options to an event
    Given the following random_event records
    | name       | registration | registration_limit | date_and_time        |
    | Great Event | true                  | 500                | February 20, 2011 |
    And I am on the new event price option page for "Great Event"
    Then I should see fields labeled Title, Description, Price, Show this option to the public
    When I fill in the following:
     | Title                          | Member      |
     | Description                    | for members |
     | Price                          | 10.00       |
     | Show this option to the public | true        |
    And I press "Save Price Option"
    Then I should be on the new event price option page for "Great Event"
    And I should see "Current Price Options"
    And I should see "Member"
    And I should see "10.00"
    And I should see fields labeled Title, Description, Price, Show this option to the public
    And I should see "Done adding price options"
    When I follow "Done adding price options"
    Then I should be on the admin event index page
 @admin_index   
  Scenario: Admin events index
    Given I am on the admin event index page
    Given the following random_event records
    | name             | address         | description              | date_and_time | registration | registration_limit |
    | Incredible Event | 100 test street | this is an awesome event | June 20th, 2020     | true         | 100                |
    And I am on the admin event index page
    Then I should see "Incredible Event"
    And I should see "Jun 20"
    And I should see "Edit"
    And I should see "Prices"
    And I should see "Registrations"
    And I should see "spots are still available"
  Scenario Outline:
    Given the following random_event records
    | name             | address         | description              | date_and_time | registration | registration_limit |
    | Incredible Event | 100 test street | this is an awesome event | June 20th, 2020     | true         | 100                |
    Given I am on the admin event index page
    When I follow <link>
    Then I should be on <page_name>
    And I should see <text>
    Examples:
      | link                    | page_name                                                        | text                                       |
      | "Edit"                  | edit event page for "Incredible Event"                           | "Edit Event"                               |
      | "Registrations"         | admin event registration group index page for "Incredible Event" | "Registration Groups for Incredible Event" |
      | "Prices"                | admin price options page for "Incredible Event"                  | "Price Options for Incredible Event"       |
      | "Edit Incredible Event" | edit event page for "Incredible Event"                           | "Edit Event"                               |
  Scenario: delete button shows for options with no registrations
    Given the following random_event records
    Given the following random_registration_group records
    Given the following random_event_price_option records
    When I go to the edit event price option page for the option titled "no registrations" and event titled "Great Event"
    Then I should see "delete"
    When I go to the edit event price option page for the option titled "1 registration" and event titled "Great Event"
    Then i should not see "delete"
  Scenario: csv
    Given I am on the admin event index page 
    And I click on number of registrations for "new event"
    Then I should be on the registrations index page for "new event"
    Given there is a registration with the first name of "jason"
    And I should see CSV export
    And I should see a table with headers entitled "name", "email", "payment status", "admin   
  #                                                    comment", "admin name", "amount", "price option name"
  #   And I should see "jason"
  #   And I should see "unpaid"
  #   When I click "unpaid"
  #   And I should see a dialogue box to "add a comment"
  #   When I fill in comment with "lower price" and press 'ok'
  #   Then I should see 'paid'
  #   And I should see "lower price"
  #   And I should see
  # 
  #   EDITING AN EVENT
  #   Given an event titled "my great event"
  #   And I'm on the edit event page for "my great event"
  #   Then I should see "manage price"
  #   And I should see a list of  price options
  #   (shortcut: drag and drop sortable list for the price options order) 

  
