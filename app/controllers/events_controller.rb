class EventsController < ApplicationController
  unloadable # http://dev.rubyonrails.org/ticket/60018
  before_filter :find_page
  before_filter :find_event_range, :only => [:index]
  include Rakismet::Controller
  rakismet_filter :only => :create
  add_breadcrumb "Home", "root_path"

  def index
    add_breadcrumb @cms_config['site_settings']['events_title']
    respond_to do |wants|
      wants.html # index.html.erb
      wants.xml { render :xml => Event.future.to_xml }
      wants.rss { render :layout => false } # uses index.rss.builder
    end
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
      @event = Event.find(params[:id], :conditions => {:active => true})
      @edit_path = [:edit, :admin, @event]
      @edit_type = "Event"
      session[:redirect_path] = event_path(@event)
      @images = @event.images
      @price_options = @event.event_price_options.public
      @latest_events = Event.future.soonest.reject { |event| event == @event }
      add_breadcrumb @cms_config['site_settings']['events_title'], events_path
      add_breadcrumb @event.name
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "That event could not be found. It may have already happened or been deleted."
      redirect_to events_path
    end
    if @cms_config['site_settings']['enable_responsive_layouts']
      #unless @event.event_category and !@event.event_category.column.blank?
        @tmplate.event_layout_id ? @main_column = Column.find(@tmplate.event_layout_id) : @main_column = Column.first(:conditions => {:column_location => "event"})
        if @event.event_category and !@event.event_category.event_layout_id.blank?
          @main_column = @main_column = Column.find(@event.event_category.event_layout_id)
        end
        @main_column_sections = ColumnSection.all(:conditions => {:column_id => @main_column.id, :visible => true, :column_section_id => nil})
      #end
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
  
  def new
    @event_categories = EventCategory.active
    @event = Event.new
    @event.active = false
  end
  
  def create
    if params[:name].blank?
      @event = Event.new(params[:event])
      @person = Person.find_or_create_by_email(params[:person])
      if !@person.valid?
        flash[:error] = "Please enter your first and last name"
        @event = Event.new(params[:event])
        render :action => 'new'
        @event.active = false
      else
        @person.save
        @event.person_id = @person.id
        @event.person_name = "#{@person.first_name} #{@person.last_name}"
        @event.person_email = @person.email
        if @event.save
          flash[:notice] = "Your event has been submitted for approval"
          EventMailer.deliver_event_notification_to_admin(@event)
          redirect_to events_path
        else
          render :action => "new"
        end
      end
    end
  end
  
  private

    def find_page
      # if @cms_config['modules']['events']
        render_404 unless @page = Page.find_by_permalink('events')
        
        @main_column = ((@page.main_column_id.blank? or Column.find_by_id(@page.main_column_id).blank?) ? Column.first(:conditions => {:title => "Default", :column_location => "main_column"}) : Column.find(@page.main_column_id))
        @main_column_sections = ColumnSection.all(:conditions => {:column_id => @main_column.id, :visible => true, :column_section_id => nil})
        @menu = @page.menus.first
        @event_categories = EventCategory.active
        @footer_pages = Page.find(:all, :conditions => {:show_in_footer => true}, :order => :footer_pos )
        @body_id = "events"
      # else
      #   render_404 unless @page = Page.find_by_permalink('events')
      #   get_page_defaults(@page)
      #   render 'pages/show'
      # end
    end

    def find_event_range
      @events_in_progress = Event.in_progress
      @events_grouped = case @settings.events_range
        when 1
          then Event.this_week.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
        when 2
          then Event.this_month.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
        when 3
          then Event.three_months.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
        when 4
          then Event.this_year.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
        when 5
          then Event.future.group_by { |e| [e.date_and_time.year, e.date_and_time.month] }
        end
      @end_date = case @settings.events_range
        when 1
          then Date.new((Time.now + 7.days).year, (Time.now + 7.days).month, (Time.now + 7.days).day)
        when 2
          then Date.new((Time.now + 30.days).year, (Time.now + 30.days).month, (Time.now + 30.days).day)
        when 3
          then Date.new((Time.now + 3.months).year, (Time.now + 3.months).month, (Time.now + 3.months).day)
        when 4
          then Date.new((Time.now + 1.year).year,(Time.now + 1.year).month, (Time.now + 1.year).day)
        when 5
          then Date.new((Time.now + 1.year).year,(Time.now + 1.year).month, (Time.now + 2.years).day)
        end
    end
end

