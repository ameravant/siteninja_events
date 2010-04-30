class Admin::EventRegistrationGroupsController < AdminController
  def index
    @event = Event.find(params[:event_id], :include => 'event_registration_groups')
    @groups = @event.event_registration_groups
    @registrations = @groups.collect(&:event_registrations).flatten
  end
end