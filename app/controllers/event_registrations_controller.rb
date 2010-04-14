class EventRegistrationsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_page_and_event

  def new
    @event_group = EventRegistrationGroup.find(params[:event_registration_group_id])
    @event = Event.find(params[:event_id])
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

