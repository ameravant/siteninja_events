class Admin::EventsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_event, :only => [ :edit, :update, :destroy, :restore ]

  # Configure breadcrumb
  before_filter :add_crumbs, :except => :index
  add_breadcrumb "New", nil, :only => [ :new, :create ]

  def index
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
    
  end

  def new
    @event_categories = EventCategory.active
    @event = Event.new
    @event.active = false if current_user.has_role("Event Contributor")
  end

  def edit
    @event_categories = EventCategory.active
    add_breadcrumb @event.name
  end

  def create
    @event = Event.new(params[:event])
    @event.event_price_options.build(params[:event_price_options])
    @event.person_id = current_user.person.id
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
    add_breadcrumb @event.name
    if @event.update_attributes(params[:event])
      if @event.registration and @event.event_price_options.reject{|o| !o.public}.empty?
        epo = @event.event_price_options.build(params[:event_price_options])
        epo.public = true
        epo.save
      end
      flash[:notice] = "#{@event.name} updated."
      redirect_to admin_events_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @event.destroy
    respond_to :js
  end

private

  def find_event
    begin
      @event = Event.find(params[:id])
    rescue
      flash[:error] = "Event not found."
      redirect_to admin_events_path
    end
  end

  def authorization
    authorize(@permissions['events'], "Events")
    current_user.has_role(["Admin", "Event Author"]) ? @disabled = false : @disabled = true
  end
  def add_crumbs
    add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
  end
end

