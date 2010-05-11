class Admin::EventsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_event, :only => [ :edit, :update, :destroy, :restore ]

  # Configure breadcrumb
  before_filter :add_crumbs, :except => :index
  add_breadcrumb "New", nil, :only => [ :new, :create ]

  def index
    if params[:q].blank?
      add_breadcrumb @cms_config['site_settings']['events_title']
      @all_events = Event.all
    else
      add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
      add_breadcrumb "Search"
      @all_events = Event.find :all, :conditions => ["name like ?", "#{params[:q]}%"], :order => "date_and_time desc"
    end
    @events = @all_events.sort_by(&:created_at).reverse.paginate(:page => params[:page], :per_page => 50)
  end

  def new
    @event = Event.new
  end

  def edit
    add_breadcrumb @event.name
  end

  def create
    @event = Event.new(params[:event])
    @event.event_price_options.build(params[:event_price_options])
    @event.person_id = current_user.person.id
    if @event.save
      flash[:notice] = "Event created, would you like to add price options"
      redirect_to new_admin_event_event_price_option_path(@event)
    else
      render :action => "new"
    end
  end

  def update
    add_breadcrumb @event.name
    if @event.update_attributes(params[:event])
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
  end
  def add_crumbs
    add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
  end
end

