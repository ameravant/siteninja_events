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
    if @price_option.save
      redirect_to admin_event_event_price_options_path(@price_option.event)
      flash[:notice] = "You've added a new price option. Would you like to add another?"
    else
      render :edit
    end
  end
  def destroy
    if @price_option.event_registrations.empty?
      @price_option.destroy
      redirect_to admin_event_event_price_options_path(@price_option.event)
      flash[:notice] = "Price option removed"
    else
       @price_option.public = false
       if @price_option.save
         redirect_to admin_event_event_price_options_path(@price_option.event)
         flash[:notice] = "Price Option removed"
       end
     end
   end
  private
  def get_option
    @price_option = EventPriceOption.find(params[:id])
    @event = @price_option.event
  end
end