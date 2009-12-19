class Admin::EventPricesController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :authorization
  before_filter :find_event
  before_filter :find_event_price, :only => [ :edit, :update, :destroy ]

  # Configure breadcrumb
  before_filter :add_crumbs
  

  def index
    @event_prices = @event.event_prices.sort_by(&:price)
    add_breadcrumb "Prices"
  end

  def new
    @event_price = @event.event_prices.build
  end

  def create
    @event_price = @event.event_prices.build(params[:event_price])
    if @event_price.save
      flash[:notice] = "New event price added."
      redirect_to admin_event_event_prices_path(@event)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
    if @event_price.update_attributes(params[:event_price])
      flash[:notice] = "#{@event_price.description} price updated."
      redirect_to admin_event_event_prices_path(@event)
    else
      render :action => "edit"
    end
  end

  def destroy
    @event_price.destroy
    respond_to :js
  end


  private
    def add_crumbs
      add_breadcrumb @cms_config['site_settings']['events_title'], "admin_events_path"
      add_breadcrumb @event.name, "edit_admin_event_path(@event)"
    end
    
    def find_event
      @event = Event.find(params[:event_id])
    end

    def find_event_price
      @event_price = EventPrice.find params[:id]
    end

  def authorization
    authorize(@permissions['events'], "Event Prices")
  end
end

