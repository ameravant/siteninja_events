module EventRegistrationGroupsHelper
  def form_attributes
    'First name,Last name,Email,Phone,Company,Title,Address1,Address2,City,Zip'.split(",")
  end
  def google_checkout_button(group)
    "<form action=\"https://checkout.google.com/api/checkout/v2/checkoutForm/Merchant/#{@cms_config['site_settings']['google_merchant_id']}\" id=\"BB_BuyButtonForm\" method=\"post\" name=\"BB_BuyButtonForm\" target=\"_top\">
        <input name=\"item_name_1\" type=\"hidden\" value=\"#{group.event.name}\"/>
        <input name=\"item_description_1\" type=\"hidden\" value=\"for #{pluralize(group.event_registrations.size, 'registration')}\"/>
        <input name=\"item_quantity_1\" type=\"hidden\" value=\"1\"/>
        <input name=\"item_price_1\" type=\"hidden\" value=\"#{group.total_price}\"/>
        <input name=\"item_currency_1\" type=\"hidden\" value=\"USD\"/>
        <input name=\"_charset_\" type=\"hidden\" value=\"utf-8\"/>
        <input alt=\"\" src=\"https://checkout.google.com/buttons/buy.gif?merchant_id=#{@cms_config['site_settings']['google_merchant_id']}&amp;w=117&amp;#{[events_url].to_query('continue_url')}&amp;h=48&amp;style=white&amp;variant=text&amp;loc=en_US\" type=\"image\"/>
    </form>"
  end
  
  def paid_icon(record, link, record_name, display)
    link_to_remote(
      image_tag("#{icons_loc}/red/16x16/Star.png", :class => "icon", :title => "Pay for #{record_name} on homepage", :alt => "Feature #{record_name} on homepage", :id => "#{dom_id(record)}_feature_icon", :style => "display: #{display};"),
      {
        :url => link,
        :with => "paid=false",
        :method => :delete, 
        :failure => "$('#{dom_id(record)}_feature_icon').src = '#{exclamation_loc}'",
        :loading => "$('#{dom_id(record)}_feature_icon').src = '#{spinner_loc}'",
        :success => "$('#{dom_id(record)}_feature_icon').src = '#{icons_loc}/red/16x16/Star.png'; $('#{dom_id(record)}_feature_icon').hide(); $('#{dom_id(record)}_defeature_icon').show()",
        :delay => 1
      }, :class => "icon")
  end
  # link_to(image_tag("#{icons_loc}/gray/16x16/Star.png", :class => "icon", :title => "#{record_name} must have images to be featured on the homepage.", :alt => "#{record_name} must have images to be featured on the homepage.", :id => "#{dom_id(record)}_feature_icon"), link, :class => "icon")
  
end