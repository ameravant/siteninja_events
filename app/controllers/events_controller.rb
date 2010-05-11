class EventsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_page
  before_filter :find_event_range, :only => [:index]
  add_breadcrumb "Home", "root_path"

  def index
    add_breadcrumb @cms_config['site_settings']['events_title']
  end

  # def past
  #   @past = true
  #   @past_events = []
  #   @events = Event.past
  #   render :action => "index"
  # end
  # 
  def past
    @events_grouped = Event.past.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
  end

  def show
    begin
      @event = Event.find(params[:id])
      @price_options = @event.event_price_options.public
      @latest_events = Event.future.soonest.reject { |event| event == @event }
      add_breadcrumb @cms_config['site_settings']['events_title'], events_path
      add_breadcrumb @event.name
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "That event could not be found. It may have already happened or been deleted."
      redirect_to events_path
    end
  end

  def pay
    # continue an event registration with a shorter URL
    # only takes a param of the registration ID
    registration = Registration.find(params[:id])

    unless registration.event.registration_spots?
      flash[:notice] = "This event is already full."
      redirect_to events_path
      return
    end

    if registration.paid?
      flash[:error] = "This registration is already completed."
      redirect_to event_path(registration.event.permalink)
    else
      redirect_to event_registration_registration_contacts_path(registration.event, registration)
    end
  end


  private

    def find_page
      @page = Page.find_by_permalink 'events'
      @menu = @page.menus.first
      @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
    end

    def find_event_range
    @events_grouped = case @settings.events_range
      when 1
        then Event.this_week.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
      when 2
        then Event.this_month.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
      when 3
        then Event.three_months.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
      when 4
        then Event.this_year.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
      when  5
        then Event.future.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
      end
    end
end

