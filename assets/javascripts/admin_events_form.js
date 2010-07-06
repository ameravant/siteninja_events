// # <script type="text/javascript" charset="utf-8">
// #   Event.observe(window, "load", function() {
// #     <%- if @event.registration? -%>
// #     jQuery('payments-allowed').show();
// #     jQuery('registration_limit').show();
// #     <%- end -%>
// #     <%- if @event.allow_check? -%>
// #     jQuery('check-payment-options').show();
// #     <%- end -%>
// #     
// #     // If they enter a registration limit, prefill the explanation text box with a generic message
// #     Event.observe(jQuery('event_registration_limit'), "change", function() {
// #       if (jQuery('event_registration_closed_text').value == "")
// #         jQuery('event_registration_closed_text').value = "Sorry, this event is closed because registration is full."
// #     });
// # 
// #     // Allowed payment fields
// #     var event_registration = jQuery('event_registration');
// #     Event.observe(event_registration, "change", function() {
// #       if (event_registration.checked) {
// #         // Show payment option checkboxes
// #         jQuery('payments-allowed').appear();
// #         jQuery('registration_limit').appear();
// #       }
// #       else {
// #         // Clear any data entered for payments or checks
// #         jQuery('event_allow_card').checked = false;
// #         jQuery('event_allow_cash').checked = false;
// #         jQuery('event_allow_check').checked = false;
// #         jQuery('event_check_instructions').value = '';
// #         // Hide the check info fields
// #         jQuery('registration_limit').fade();
// #         jQuery('payments-allowed').fade();
// #         jQuery('check-payment-options').fade();
// #       }
// #     });
// # 
// #     // Check information fields
// #     var event_allow_check = jQuery('event_allow_check');
// #     Event.observe(event_allow_check, "change", function() {
// #       if (event_allow_check.checked) {
// #         // Show check info fields
// #         jQuery('check-payment-options').appear();
// #       }
// #       else {
// #         // Clear any data entered
// #         jQuery('event_check_instructions').value = '';
// #         // Hide the check info fields
// #         jQuery('check-payment-options').fade();
// #       }
// #     });
// #   });
// # </script>
function initRegistrationOptions() {
  jQuery('div#registration-ops :checkbox').click( 
  	function() {
        if(this.checked){
          jQuery('div.registration-options').show("fast");
        }else{
          jQuery('div.registration-options').hide("fast");
       }
	 }
  );
}
jQuery(document).ready(function () {
  jQuery("body").addClass("jsenabled");
  initRegistrationOptions();
}
);
