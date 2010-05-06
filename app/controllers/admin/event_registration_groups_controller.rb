class Admin::EventRegistrationGroupsController < AdminController
  def index
    @event = Event.find(params[:event_id], :include => 'event_registration_groups')
    @groups = @event.event_registration_groups
    @registrations = @groups.collect(&:event_registrations).flatten
    @people = @registrations.collect(&:person).flatten.sort_by(&:last_name)
    
    respond_to do |wants|
      require 'fastercsv'
      wants.html
      wants.csv do
        @outfile = @event.name + "_registrations_" + Time.now.strftime("%m-%d-%Y") + ".csv"
        csv_data = FasterCSV.generate do |csv|
          csv << ["Last Name", "First Name", "Email", "Total", "Paid"]
          @people.each do |person|
            group = person.registration_group_for(@event)
            registration = person.event_registrations.find(:first, :conditions => "event_registration_group_id = #{group.id}")
            csv << [person.last_name, person.first_name, person.email, "$" + registration.event_transaction.total, group.is_paid? ]
          end
        end
        send_data csv_data,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=#{@outfile}"
        flash[:notice] = "Export complete!"
      end
    end
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