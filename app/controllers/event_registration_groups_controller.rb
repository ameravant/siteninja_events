class EventRegistrationGroupsController < ApplicationController
  unloadable
  def new
    @event = Event.find(params[:event_id])
    @event_registration_group = EventRegistrationGroup.new
    @person ||= Person.new
    @event_price_options = @event.event_price_options.public
  end
  def create
    if params[:event_kind].blank?
      @event = Event.find(params[:event_id])
      @person = Person.find_or_create_by_email(params[:person])
      @event_price_options = @event.event_price_options.public
      
      if @person.save
        if @event_price_options.size > 1
          @event_registration_group = EventRegistrationGroup.new(params[:event_registration_group])
        else
          @event_registration_group = EventRegistrationGroup.new
        end
        @event_registration_group.owner = @person
        @event_registration_group.event_id = @event.id
        @event_registration_group.title = ("%s %s's group for %s - %d" % [@person.first_name, @person.last_name, @event.name, Time.now.strftime("%b %d, %Y at %I:%M %p")]).titleize
        @event_price_options.size == 1 ? epo_id = @event_price_options.first.id : epo_id = params[:event_registration][:event_price_option_id]
        if @event_registration_group.save
          #if @event_registration_group.is_attending == true
            @event_registration = EventRegistration.create(:person_id => @person.id, :event_price_option_id => epo_id, :event_registration_group_id => @event_registration_group.id )
          #end
          registration = @event_registration
          EventTransaction.create(:event_registration_id => registration.id, 
                                  :total => registration.event_price_option.price,
                                  :description => registration.event_price_option.description,
                                  :title => registration.event_price_option.title
                                  )
          if params[:self_registration]
            if params[:payment]
              redirect_to event_event_registration_group_path(@event, @event_registration_group, :params => {:pay_method => params[:payment][:method]})
            else
              redirect_to event_event_registration_group_path(@event, @event_registration_group)              
            end
            #flash[:notice] = "test #{params[:payment_method]}"
          else
            redirect_to new_event_event_registration_group_event_registration_path(@event, @event_registration_group)
            flash[:notice] = "Thanks for registering, would you like to register any other guests?"
          end
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