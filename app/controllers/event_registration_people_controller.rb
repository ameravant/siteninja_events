class EventRegistrationPeopleController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_event_and_registration

  def index
    if @registration.paid
      flash[:error] = "That registration is already completed."
      redirect_to event_path(@event.permalink)
    else
      @event_prices = @event.event_prices.sort_by(&:price)
      @event_price = @event_prices.first
      @registration_contacts = EventRegistrationPerson.find(:all,
        :conditions => { :event_registration_id => @registration.id }, :include => :person,
        :include => :event_price, :order => "event_prices.price")
    end
    @meta_title = "Registration Attendees - #{@event.name}"
  end

  def create
    @event_price = EventPrice.find(params[:event_price][:id])

    unless @event.registration_spots?
      flash[:error] = "Your guest could not be added because the event is now full."
      redirect_to event_registration_registration_contacts_path(@event, @registration)
      return
    end

    @contact = Contact.new(params[:contact])
    @event_prices = @event.event_prices.sort_by(&:price)
    @registration_contacts = @registration.registration_contacts

    if @contact.valid? and @event_price
      @registration_contact = RegistrationContact.new(params[:registration_contact])
      @registration_contact.event_registration_id = @registration.id
      @registration_contact.event_price_id = @event_price.id

      if @registration_contact.valid?
        @contact.save # only save contact if registration is valid
        @registration_contact.update_attributes(:contact_id => @contact.id)
        flash[:notice] = "#{@contact.name.titleize} has been added to your guest list."
        redirect_to event_registration_registration_contacts_path(@event, @registration)
      else # registration contact not saved
        render :action => "index"
      end

    else # contact not saved
      render :action => "index"
    end
  end

  def destroy
    @registration_contact = RegistrationContact.find(params[:id])
    @registration_contact.destroy
    flash[:notice] = "#{@registration_contact.contact.name.titleize} has been removed from your guest list."
    redirect_to event_registration_registration_contacts_path(@event, @registration)
  end


  private

    def find_event_and_registration
      begin
        @page = Page.find_by_permalink 'events'
        @event = Event.find params[:event_id]
        @registration = EventRegistration.find params[:event_registration_id]
      rescue
        redirect_to events_path
      end
    end

end

