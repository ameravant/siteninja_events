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
  toggleBasedOnChecked('div#registration-ops :checkbox', 'div.registration-options');
  toggleBasedOnChecked('input#event_allow_check', 'div#check-payment-options');
}
jQuery(document).ready(function () {
  jQuery("body").addClass("jsenabled");
  initRegistrationOptions();
}
);
