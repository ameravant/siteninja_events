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

