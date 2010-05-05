module EventRegistrationGroupsHelper
  def form_attributes
    'First name,Last name,Email,Phone,Company,Title,Address1,Address2,City,Zip'.split(",")
  end
  def google_checkout_button(event)
    event.event.name
  end
end