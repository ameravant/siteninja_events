class EventRegistrationsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_page_and_event

  def new
    @event_group = EventRegistrationGroup.find(params[:event_registration_group_id])
    @event_price_options = @event.event_price_options
    @event_registration = EventRegistration.new
    @current_guests = @event_group.people 
    # @current_guests << @event_group.owner if @event_group.owner_is_attending?
  end
  def create
    @event = Event.find(params[:event_id])
    @event_price_options = @event.event_price_options
    @event_registration_group = EventRegistrationGroup.find(params[:event_registration_group_id])
    @event_group = @event_registration_group
    @person = Person.find_by_email(params[:person][:email])
    @person ||= Person.new(params[:person])
    @event_registration = EventRegistration.new(params[:event_registration])
    @person.person_group_ids = @person.person_group_ids << PersonGroup.find_by_title("#{@event.name}-#{@event.id}").id
    if @person.save
      @event_registration.person = @person
      @event_registration.event_registration_group_id = @event_registration_group.id
      # @event_registration.event_id = @event.id
      if @event_registration.save
        EventTransaction.create(:event_registration_id => @event_registration.id, :total => @event_registration.event_price_option.price, :title => @event_registration.event_price_option.title )
        redirect_to new_event_event_registration_group_event_registration_path(@event, @event_registration_group)
        @event_registration_group.update_attributes(:total_price => @event_registration_group.subtotal)
        "A new guest has been added to your registration"
      else 
        render :action => "new" and return
      end
    else
      render :action => "new" and return   
    end      
  end
private
  def find_page_and_event
    begin
      @page = Page.find_by_permalink 'events'
      @event = Event.find params[:event_id]
    rescue
      redirect_to events_path
    end
  end
end

