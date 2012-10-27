class EventCategoriesController < ApplicationController
  unloadable
  add_breadcrumb 'Home', 'root_path'
  before_filter :add_crumbs
  before_filter :find_page
  before_filter :find_events_for_sidebar
  
  def show
    begin
      @event_category.menus.empty? ? @menu = @page.menus.first : @menu = @event_category.menus.first
      @events = @event_category.events.future.paginate(:page => params[:page], :per_page => 10, :include => :event_categories)
      add_breadcrumb @event_category.title
    end
    # respond_to do |wants|
    #   wants.html # index.html.erb
    #   wants.xml { render :xml => @events.to_xml }
    #   wants.rss { render :layout => false } # uses index.rss.builder
    # end
  end

  private

  def add_crumbs
    add_breadcrumb @cms_config['site_settings']['event_title'], 'event_path'
  end

  def find_page
    if @cms_config['modules']['events']
      @event_category = EventCategory.active.find(params[:id])
      if @event_category.blank?
        render_404
      else
        @page = Page.find_by_permalink('events')
        @main_column = ((@page.main_column_id.blank? or Column.find_by_id(@page.main_column_id).blank?) ? Column.first(:conditions => {:title => "Default", :column_location => "main_column"}) : Column.find(@page.main_column_id))
        @main_column_sections = ColumnSection.all(:conditions => {:column_id => @main_column.id, :visible => true, :column_section_id => nil})
      end
    else
      unless @page = Page.find_by_permalink('events')
        render_404
      else
        get_page_defaults(@page)
        render 'pages/show'
      end
    end
  end

  def find_events_for_sidebar
    @event_categories = EventCategory.active
  end
  
end

