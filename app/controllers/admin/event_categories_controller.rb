class Admin::EventCategoriesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_event_category, :only => [ :edit, :update, :destroy ]
  before_filter :add_crumbs
  add_breadcrumb "Categories", "admin_event_categories_path", :except => [ :index, :destroy ]
  add_breadcrumb "New Category", nil, :only => [ :new, :create ]
  
  def index
    @event_categories = EventCategory.active
    add_breadcrumb "Categories", nil
  end

  def new
    @event_category = EventCategory.new
  end

  def create
    @event_category = EventCategory.new(params[:event_category])
    if @event_category.save
      flash[:notice] = "Category \"#{@event_category.title}\" created."
      redirect_to admin_event_categories_path
    else
      render :action => "new"
    end
  end

  def edit
    add_breadcrumb @event_category.title
  end

  def update
    add_breadcrumb @event_category.title
    if @event_category.update_attributes(params[:event_category])
      flash[:notice] = "Category \"#{@event_category.title}\" updated."
      redirect_to admin_event_categories_path
    else
      render :action => "edit"
    end
  end

  def destroy
    @event_category.update_attribute(:active, false)
    respond_to :js
  end

  private

  def find_event_category
    begin
      @event_category = EventCategory.find_by_permalink(params[:id])
    rescue ActiveRecord::RecordNotFound
      flash[:error] = "Event category was not found. It may have been deleted."
      redirect_to admin_event_categories_path
    end
  end

  def authorization
    authorize(@permissions['events'], "Event Categories")
  end

  def add_crumbs
    add_breadcrumb @cms_config['site_settings']['event_title'], "admin_events_path"
  end
end

