function toggleBasedOnChecked(checkbox, target) {
  jQuery(checkbox).click( 
    	function() {
          if(this.checked){
            jQuery(target).show("fast");
          }else{
            jQuery(target).hide("fast");
         }
  	 }
   );
}
function initRegistrationOptions() {
  if (jQuery('#event_registration').is(':checked')) {
    jQuery('div#check-payment-options, div.registration-options').css('display', 'block');
  }else{
    jQuery('div#check-payment-options, div.registration-options').css('display', 'none');
  };
  toggleBasedOnChecked('div#registration-ops :checkbox', 'div.registration-options');
  toggleBasedOnChecked('input#event_allow_check', 'div#check-payment-options');
}
jQuery(document).ready(function () {
  initRegistrationOptions();
}
);
