

$(document).ready(function(){ 
  $("input#same").click(function(){ 
    if ($("input#same").is(':checked')) 
      { 
        // Checked, copy values 
        $("input#order_del_name").val($("input#order_billing_name").val()); 
        $("input#order_del_email").val($("input#order_billing_email").val()); 
        $("input#order_del_phone").val($("input#order_billing_phone").val()); 
        $("input#order_del_street").val($("input#order_billing_street").val()); 
        $("input#order_del_city").val($("input#order_billing_city").val());
        $("input#order_del_state").val($("input#order_billing_state").val()); 
        $("select#order_del_country").val($("select#order_billing_country").val()); 
        $("input#order_del_post").val($("input#order_billing_post").val());
      } 
    else 
      { 
        // Clear on uncheck 
        $("input#order_del_name_input").val(""); 
        $("input#order_del_email_input").val(""); 
        $("input#order_del_phone_input").val(""); 
        $("input#order_del_street_input").val(""); 
        $("input#order_de_city_input").val(""); 
        $("input#order_del_state_input").val(""); 
        $("select#order_del_country_input").val(""); 
        $("input#order_del_post_input").val(""); 
      } 
  }); 
});