class EventMailer < ActionMailer::Base
  SMTP_SETTINGS = {
    :address => "smtp.sendgrid.net",
    :port => 587,
    :enable_starttls_auto => true,
    :authentication => :login,
    :domain => $DOMAIN,
    :user_name => $MASTER_CONFIG['site_settings']['sendgrid_username'],
    :password => $MASTER_CONFIG['site_settings']['sendgrid_password'],
  }
  
  def event_notification_to_admin(event)   
    person = event.person 
    setup_email(Setting.first.inquiry_notification_email, $CMS_CONFIG['website']['name'], "#{person.name} has submitted a new event to #{$CMS_CONFIG['website']['name']} - Event ##{event.id}.")
    body :person => person, :event => event
  end
  
  def event_notification_to_user(event)   
    person = event.person 
    setup_email(person.email, person.name, "Thank you for you submission.")
    body :person => person, :event => event
  end
  
  private

  def setup_email(email, name, subject)
    cms_config ||= YAML::load_file("#{RAILS_ROOT}/config/cms.yml")
    recipients   "#{name.strip} <#{email.strip}>"
    from         "#{$CMS_CONFIG['website']['name']} <#{Setting.first.inquiry_notification_email}>"
    headers      'Reply-to' => "#{$CMS_CONFIG['website']['name'].strip} <#{Setting.first.inquiry_notification_email.strip}>"
    subject      subject.strip
    sent_on      Time.now
    content_type 'text/html'
  end
end