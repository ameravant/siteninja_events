class Admin::EventsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_event, :only => [ :edit, :update, :destroy, :restore ]
  before_filter :update_timezone, :only => [:create, :update]
  # Configure breadcrumb
  before_filter :add_crumbs, :except => :index
  add_breadcrumb "New", nil, :only => [ :new, :create ]
  
  require 'fastercsv'
  require 'csv'

  def index
    session[:redirect_path] = admin_events_path
    if current_user.has_role("Admin") # Show all articles regardless of author
      params[:q].blank? ? @all_events = Event.all : @all_events = Event.all(:conditions => ["name like ?", "%#{params[:q]}%"], :order => "date_and_time desc")
    else
      params[:q].blank? ? @all_events = Event.all(:conditions => {:person_id => current_user.person.id}) : @all_events = Event.find(:all, :conditions => ["title like ? and person_id = ?", "%#{params[:q]}%", current_user.person.id])
    end
    @events = @all_events.sort_by(&:date_and_time).reverse.paginate(:page => params[:page], :per_page => 50)
    
    if params[:q].blank?
      add_breadcrumb @cms_config['site_settings']['events_title']
      @all_events = Event.all
    else
      add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
      add_breadcrumb "Search"
      @all_events = Event.find :all, :conditions => ["name like ?", "%#{params[:q]}%"], :order => "date_and_time desc"
    end

    # Export CSV
    respond_to do |wants|
      require 'fastercsv'
      wants.html
      wants.csv do
        @outfile = "events_" + Time.now.strftime("%m-%d-%Y") + ".csv"
        csv_data = FasterCSV.generate do |csv|
          csv << ["Name", "Address", "Description", "Long Description", "Start Date and Time", "End Date and Time", "Repeat", "Repeat Start Date", "Repeat Start Time", "Repeat End Date", "Repeat End Time", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "First Weekday", "Second Weekday", "Third Weekday", "Fourth Weekday", "Last Weekday", "Repeat Frequency"]
          @all_events.each do |event|
            csv << [event.name, event.address, event.description, event.blurb, event.date_and_time, event.end_date_and_time, event.repeat, event.repeat_start_date, event.repeat_start_time, event.repeat_end_date, event.repeat_end_time, event.monday, event.tuesday, event.wednesday, event.thursday, event.friday, event.saturday, event.sunday, event.repeat_frequency]
          end
        end
        send_data csv_data,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=#{@outfile}"
        flash[:notice] = "Export complete!"
      end
    end

    
  end

  def new
    @event_categories = EventCategory.active
    @event = Event.new
    if params[:duplicate_id]
      @event = Event.find(params[:duplicate_id]).clone
    end
    if @full_access == false
      @event.active = false if current_user.has_role("Event Contributor")
    end
  end

  def edit
    @event_categories = EventCategory.active
    add_breadcrumb @event.name
  end

  def create
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info params[:event][:date_and_time]
    logger.info "================================================="
    params[:event][:event_category_ids] ||= []
    params[:event][:event_category_ids] << params[:event][:event_category_id] unless params[:event][:event_category_id].blank? or params[:event][:event_category_ids].include?(params[:event][:event_category_id])
    params[:event][:repeat_start_time] = params[:event][:repeat_start_time_string]
    params[:event][:repeat_end_time] = params[:event][:repeat_end_time_string]
    params[:event][:repeat_start_time] = Time.zone.parse(params[:event][:repeat_start_time]) if !params[:event][:repeat_start_time].blank?
    params[:event][:repeat_end_time] = Time.zone.parse(params[:event][:repeat_end_time]) if !params[:event][:repeat_end_time].blank?
    if params[:event][:start_date] and params[:event][:start_time]
      params[:event][:date_and_time] = "#{params[:event][:start_date]} #{params[:event][:start_time]} #{@time_zone}"
    end
    if params[:event][:end_date] and params[:event][:end_time]
      params[:event][:end_date_and_time] = "#{params[:event][:end_date]} #{params[:event][:end_time]} #{@time_zone}"
    end
    if params[:event][:repeat] == "1"
      params[:event][:date_and_time] = "#{params[:event][:repeat_start_date].to_time.strftime('%m/%d/%Y')} #{params[:event][:repeat_start_time].to_time.strftime('%I:%M %p')}"
      params[:event][:end_date_and_time] = "#{params[:event][:repeat_end_date].to_time.strftime('%m/%d/%Y')} #{params[:event][:repeat_end_time].to_time.strftime('%I:%M %p')}"
    end
    @event = Event.new(params[:event])
    @event.event_price_options.build(params[:event_price_options])
    @event.person_id = current_user.person.id if current_user.person
    if @event.save
      if @event.registration?
        flash[:notice] = "Event created, would you like to add price options"
        redirect_to new_admin_event_event_price_option_path(@event)
      else
        flash[:notice] = "Event created"
        redirect_to admin_events_path
      end
    else
      render :action => "new"
    end
  end

  def update
    add_breadcrumb '@event.name'
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info "================================================="
    logger.info params[:event][:date_and_time]
    logger.info "================================================="
    params[:event][:event_category_ids] ||= []
    params[:event][:event_category_ids] << params[:event][:event_category_id] unless params[:event][:event_category_id].blank? or params[:event][:event_category_ids].include?(params[:event][:event_category_id])
    params[:event][:repeat_start_time] = params[:event][:repeat_start_time_string]
    params[:event][:repeat_end_time] = params[:event][:repeat_end_time_string]
    params[:event][:repeat_start_time] = Time.zone.parse("#{params[:event][:repeat_start_date]} #{params[:event][:repeat_start_time]}") if !params[:event][:repeat_start_time].blank?
    params[:event][:repeat_end_time] = Time.zone.parse("#{params[:event][:repeat_end_date]} #{params[:event][:repeat_end_time]}") if !params[:event][:repeat_end_time].blank?
    if params[:event][:start_date] and params[:event][:start_time]
      params[:event][:date_and_time] = "#{params[:event][:start_date]} #{params[:event][:start_time]} #{@time_zone}"
    end
    if params[:event][:end_date] and params[:event][:end_time]
      params[:event][:end_date_and_time] = "#{params[:event][:end_date]} #{params[:event][:end_time]} #{@time_zone}"
    end
    if params[:event][:repeat] == "1"
      params[:event][:date_and_time] = "#{params[:event][:repeat_start_date].to_time.strftime('%m/%d/%Y')} #{params[:event][:repeat_start_time].to_time.strftime('%I:%M %p')}"
      params[:event][:end_date_and_time] = "#{params[:event][:repeat_end_date].to_time.strftime('%m/%d/%Y')} #{params[:event][:repeat_end_time].to_time.strftime('%I:%M %p')}"
    end
    if @event.update_attributes(params[:event])
      if @event.registration and @event.event_price_options.reject{|o| !o.public}.empty?
        epo = @event.event_price_options.build(params[:event_price_options])
        epo.public = true
        epo.save
      end
      flash[:notice] = "#{@event.name} updated."
      redirect_to params[:redirect_path] ? params[:redirect_path] : admin_events_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @event.destroy
    respond_to :js
  end

private

  def update_timezone
    params[:event][:date_and_time] = Time.zone.parse(params[:event][:date_and_time]) if !params[:event][:date_and_time].blank?
    params[:event][:end_date_and_time] = Time.zone.parse(params[:event][:end_date_and_time]) if !params[:event][:end_date_and_time].blank?
  end

  def find_event
    begin
      @event = Event.find(params[:id])
    rescue
      flash[:error] = "Event not found."
      redirect_to admin_events_path
    end
  end

  def authorization
    if @cms_config['modules']['events']
      authorize(@permissions['events'], "Events")
      current_user.has_role(["Admin", "Event Author"]) ? @full_access = true : @full_access = false
      @disabled = true if !@full_access
    else
      flash[:error] = "You do not have permission to access Events."
      redirect_to "/"
    end
  end
  def add_crumbs
    add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
  end
end

