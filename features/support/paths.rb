module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name
    
    when /the home\s?page/
      root_url
    when /the event page for "(.+)"$/
      event_path(Event.find_by_name($1))
    when /the new registration page for "(.+)"$/
      new_event_event_registration_path(Event.find_by_name($1))
    when /the new registration_group page for "(.+)"$/
      new_event_event_registration_group_path(Event.find_by_name($1))
    when /new event registration group registration page for "(.+)" and "(.+)"$/
      new_event_event_registration_group_event_registration_path(Event.find_by_name($1), EventRegistrationGroup.find_by_title($2))
    when /the add a guest page for "(.+)"$/
      new_event_event_registration_group_event_registration_path(Event.find(EventRegistrationGroup.find_by_title($1).event_id), EventRegistrationGroup.find_by_title($1))
    when /event registration group page titled "(.+)" for the event named "(.+)"$/
      event_event_registration_group_path(Event.find_by_name($2), EventRegistrationGroup.find_by_title($1))
    when /the admin event index page$/
      admin_events_path
    when /the new event page$/
      new_admin_event_path 
    when /the new event price option page for "(.+)"$/
      new_admin_event_event_price_option_path(Event.find_by_name($1)) 
    when /edit event page for "(.+)"$/
      edit_admin_event_path(Event.find_by_name($1, :order => "id DESC"))
    when /admin event registration group index page for "(.+)"$/
      admin_event_event_registration_groups_path(Event.find_by_name($1, :order => "id DESC"))
    when /admin price options page for "(.+)"$/
      admin_event_event_price_options_path(Event.find_by_name($1, :order => "id DESC"))
    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
        "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(NavigationHelpers)
