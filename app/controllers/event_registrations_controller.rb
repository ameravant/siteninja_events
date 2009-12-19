class EventRegistrationsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_page_and_event


  def new
    add_breadcrumb @cms_config['site_settings']['event_title'], events_path
    @event_prices = @event.event_prices.sort_by(&:price)
    @event_price = @event_prices.first
    @eventperson = Person.new
    @registration = EventRegistration.new
  end

  def create
    add_breadcrumb @cms_config['site_settings']['event_title'], events_path
    @event_price = EventPrice.find params[:event_price]['id']
    @registration = EventRegistration.new params[:registration]
    @eventperson = Person.find_or_create_by_email(params[:eventperson])

    if !@event.registration_spots?
      flash[:error] = "Sorry, but this event has reached capacity."
      redirect_to event_path(@event)
      return
    end

    if @registration.valid? and @eventperson.valid? and @event_price and !@registration.is_registered?(params[:eventperson][:email],params[:event_id])

      # Save contact (registration owner)
      @eventperson.save

      # Save registration
      @registration.event_id = @event.id
      @registration.person_id = @eventperson.id
      @registration.save

      # Create first registration contact as owner
      EventRegistrationPerson.create(
        :event_registration_id => @registration.id,
        :person_id => @eventperson.id,
        :event_price_id => @event_price.id
      )

      redirect_to event_event_registration_event_registration_people_path(@event, @registration)
    else
      @event_prices = @event.event_prices.sort_by(&:price)
      render :action => "new"
    end
  end

  def pay
    @pay_by = params[:by]
    @registration = Registration.find(params[:id])

    if @registration.approved
      flash[:notice] = "This registration was already approved."
      redirect_to event_path(@event.permalink)
      return
    end

    # If the user registered over 30 minute ago, and the event is full, they cannot complete
    # their registration anymore
    if @registration.created_at < 30.minutes.ago and !@event.registration_spots?
      flash[:error] = "You cannot complete your registration anymore because the event is now full."
      redirect_to event_path(@event.permalink)
      return
    end

    # Enforce allowed payment methods
    if @pay_by.blank? and !@event.allow_card
      render :text => "credit card payment not allowed for this event"
      return
    elsif @pay_by == "check" and !@event.allow_check
      render :text => "check payment not allowed for this event"
      return
    elsif @pay_by == "cash" and !@event.allow_cash
      render :text => "cash payment not allowed for this event"
      return
    end

    @registration_contacts = RegistrationContact.find(:all,
      :conditions => { :event_registration_id => @registration.id }, :include => :contact,
      :include => :event_price, :order => "event_prices.price")
  end

  def complete
    add_breadcrumb @cms_config['site_settings']['event_title'], events_path
    @registration = Registration.find params[:id]
    @registration.approved = true
    @registration.cash = (params[:by] == "cash")
    @registration.check = (params[:by] == "check")
    @registration.save

    @registration_contacts = RegistrationContact.find(:all,
      :conditions => { :event_registration_id => @registration.id }, :include => :contact,
      :include => :event_price, :order => "event_prices.price")

    @registration.send_notification_emails
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

