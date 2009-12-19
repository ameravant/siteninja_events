class Admin::EventRegistrationsController < AdminController
  unloadable # http://dev.rubyonrails.org/ticket/6001
  before_filter :find_event
  before_filter :find_registration, :only => [ :show, :paid, :unpaid ]

  def index
    @free_event = (@event.event_prices.collect(&:price).sum == 0)
    @registrations = Registration.find_all_by_event_id(@event.id, :include => :transactions)
    approved_registrations = @registrations.reject { |x| !x.approved }
    @registration_contacts = RegistrationContact.find(:all, :conditions => { :event_registration_id => approved_registrations.collect(&:id) }, :include => :contact, :include => :event_price)
  end

  def show
  end

  def paid
    @registration.paid = true
    @registration.save
    flash[:notice] = "Registration marked as paid."
    redirect_to admin_event_registrations_path(@registration.event_id)
  end

  def unpaid
    @registration.paid = false
    @registration.save
    flash[:notice] = "Registration marked as unpaid."
    redirect_to admin_event_registrations_path(@registration.event_id)
  end

  def csv
    require 'fastercsv'
    registrations = Registration.find_all_by_event_id_and_approved(@event.id, true)
    registration_contacts = RegistrationContact.find_all_by_event_registration_id(registrations.collect(&:id), :include => :contact, :order => "contacts.last_name, contacts.first_name")
    outfile = "registrations_event_#{@event.id.to_s}.csv"

    csv_data = FasterCSV.generate do |csv|
      csv << ["Last Name", "First Name", "Email", "Phone", "Registration Type", "Price", "Approved", "Paid", "Payment Method"]
      for rc in registration_contacts
        csv << [
          rc.contact.last_name,
          rc.contact.first_name,
          rc.contact.email,
          rc.contact.phone,
          rc.event_price.description,
          rc.event_price.price,
          rc.registration.approved ? "Yes" : "No",
          rc.registration.paid ? "Yes" : "No",
          rc.registration.payment_method
        ]
      end # registration
    end
    send_data csv_data, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=#{outfile}"
  end

  private

    def find_event
      @event = Event.find params[:event_id]
    end

    def find_registration
      @registration = Registration.find params[:id]
    end

end

