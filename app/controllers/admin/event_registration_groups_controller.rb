class Admin::EventRegistrationGroupsController < AdminController
  def index
    @event = Event.find(params[:event_id], :include => 'event_registration_groups')
    @groups = @event.event_registration_groups
    @registrations = @groups.collect(&:event_registrations).flatten
    @people = @registrations.collect(&:person).flatten.sort_by(&:last_name)
  end
  def update
    @group = EventRegistrationGroup.find(params[:id])
    if params[:paid] == "true"
      @group.update_attributes(:paid => true)
      # respond_to :js
    end
  end
  def destroy
    @group = Group.find(param[:id])
    @group.destroy
    respond_to :js
  end
  def show
    
  end
end