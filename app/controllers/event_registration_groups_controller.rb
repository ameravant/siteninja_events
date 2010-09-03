class EventRegistrationGroupsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @event_registration_group = EventRegistrationGroup.new
    @person ||= Person.new
    @event_registration = EventRegistration.new
    @event_price_options = @event.event_price_options
  end
  def create
    if params[:event_kind].blank?
      @event = Event.find(params[:event_id])
      @person = Person.find_by_email(params[:person][:email])
      @event_price_options = @event.event_price_options
      @person ||= Person.new(params[:person])
      @event_registration_group = EventRegistrationGroup.new(params[:event_registration_group])
      if @person.save
        @event_registration_group.owner = @person
        @event_registration_group.event_id = @event.id
        @event_registration_group.title = ("%s %s's group for %s - %d" % [@person.first_name, @person.last_name, @event.name, Time.now.to_i.to_s[-5...-1]]).titleize
        if @event_registration_group.is_attending == true
          @event_registration_group.event_registrations.build(:person_id => @person.id, :event_price_option_id => params[:event_registration][:event_price_option_id] )
        end
        if @event_registration_group.save
          registration = @event_registration_group.event_registrations.last
          EventTransaction.create(:event_registration_id => registration.id, 
                                  :total => registration.event_price_option.price,
                                  :description => registration.event_price_option.description,
                                  :title => registration.event_price_option.title
                                  )
          if @event_registration_group.is_attending
            @person.event_registration_group_ids = @person.event_registration_group_ids << @event_registration_group.id
            @person.save
          end
          redirect_to new_event_event_registration_group_event_registration_path(@event, @event_registration_group)
          flash[:notice] = "Thanks for registering, would you like to register any other guests?"
        else
          render :action => "new" and return
          flash[:notice] = "Please Try Again."
        end
      else
        render :action => "new" and return
        flash[:notice] = "Please try again"
      end
    else
      redirect_to "/" and return
    end    
  end
  def show
    @event = Event.find(params[:event_id])
    @event_registration_group = EventRegistrationGroup.find(params[:id])
    @current_guests = @event_registration_group.people
    if params[:pay_method]
      @event_registration_group.update_attributes(:pay_method => params[:pay_method], :total_price => @event_registration_group.subtotal)
    end
  end
end