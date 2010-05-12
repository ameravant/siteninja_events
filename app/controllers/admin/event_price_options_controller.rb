class Admin::EventPriceOptionsController < AdminController
  before_filter :get_option, :only => [:edit, :update, :destroy]
  def new
    @price_option = EventPriceOption.new
    @event = Event.find(params[:event_id], :include => "event_price_options")
  end
  def create
    @price_option = EventPriceOption.new(params[:event_price_option])
    @price_option.event_id = params[:event_id]
    if @price_option.save
      flash[:notice] = "Price Option created. Would you like to add another?"
      redirect_to new_admin_event_event_price_option_path(@price_option.event)
    else
      render :new and return
    end
  end
  def index
    @event = Event.find(params[:event_id], :include => "event_price_options")
    @prices = @event.event_price_options.public
  end
  def edit
    
  end
  def update
    if @price_option.update_attributes(params[:event_price_option])
      redirect_to admin_event_event_price_options_path(@price_option.event)
      flash[:notice] = "You've changed this price option. Would you like to add another?"
    else
      render :edit
    end
  end
  def destroy
    @price_option.destroy
    respond_to :js
   end
  private
  def get_option
    @price_option = EventPriceOption.find(params[:id])
    @event = @price_option.event
  end
end