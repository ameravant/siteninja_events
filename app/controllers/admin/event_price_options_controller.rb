class Admin::EventPriceOptionsController < AdminController
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
end