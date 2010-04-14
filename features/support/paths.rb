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
