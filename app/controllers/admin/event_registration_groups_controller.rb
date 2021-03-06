class Admin::EventRegistrationGroupsController < AdminController
  unloadable
  add_breadcrumb "Calendar", "admin_events_url"
  def index
    @event = Event.find(params[:event_id])
    @groups = PersonGroup.all(:conditions => {:event_id => @event.id})
    @registrations = @groups.collect(&:event_registrations).flatten
    @people = @registrations.collect(&:person).flatten.sort_by(&:last_name)
    
    respond_to do |wants|
      require 'fastercsv'
      wants.html
      wants.csv do
        @outfile = @event.name.gsub(" ", "_") + "_registrations_" + Time.now.strftime("%m-%d-%Y")
        csv_data = FasterCSV.generate do |csv|
          csv << ["Last Name", "First Name", "Owner Phone", "Email", "Total", "Paid", "Payment Method", "type", "Company", "Transaction Date"]
          @people.each do |person|
            group = person.registration_group_for(@event)
            registration = person.event_registrations.find(:first, :conditions => "event_registration_group_id = #{group.id}")
            csv << [person.last_name, person.first_name, group.owner.phone, person.email, (registration.event_transaction.blank? ? "" : registration.event_transaction.total), group.is_paid?, group.pay_method, (registration.event_price_option.title_and_price if registration.event_price_option), person.company, (registration.event_transaction.blank? ? "" : registration.event_transaction.created_at.strftime("%m/%d/%Y - %I:%M %p"))]
          end
        end
        send_data csv_data,
        :type => 'text/csv; charset=iso-8859-1; header=present',
        :disposition => "attachment; filename=#{@outfile}.csv"
        flash[:notice] = "Export complete!"
      end
    end
  end
  def update
    @group = EventRegistrationGroup.find(params[:id])
    if params[:paid]
      @group.update_attributes(:paid => params[:paid])
      respond_to :js
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