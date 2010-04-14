class EventRegistrationGroupsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @event_registration_group = EventRegistrationGroup.new
    @person = Person.new
    @event_registration = EventRegistration.new
    @event_price_options = @event.event_price_options
  end
  def create
    @event = Event.find(params[:event_id])
    @event_registration_group = EventRegistrationGroup.new(params[:event_registration_group])
    @person = Person.new(params[:person])
    if @person.save
      @event_registration_group.person = @person
      @event_registration_group.title = ("%s %s's group for %s" % [@person.first_name, @person.last_name, @event.name]).titleize
      if @event_registration_group.save
        @event_registration_group.event_registrations.build(:person_id => @person.id)
      else
        render :action => "new" and return
        flash[:notice] = "something went wrong"
      end
    else
      render :action => "new" and return
      flash[:notice] = "Please try again"
    end
    redirect_to new_event_event_registration_group_event_registration_url(@event, @event_registration_group) and return
    flash[:notice] = "Thanks for registering, would you like to register any other guests?"    
  end
end