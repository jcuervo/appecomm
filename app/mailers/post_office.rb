class PostOffice < ActionMailer::Base
  # Delivered when an order is processed.
  
  default :from => "noreply@domain.com"
  
  def order_email(order, cart_items, recipient, subject)
  @order = order
  @cart_items = cart_items
    mail(
      :to => recipient, 
      :subject => "Domain : #{subject}",
      :content_type => "text/html", 
    )
  end  
  
  def contact_form(email_data)
    subject = "Contact from your website"

    recipients   ADMIN_EMAIL
    from         email_data[:email_address]
    subject      subject
    content_type "text/html"
    body         :mail_data => format_field_names(email_data), :subject => subject
  end

 private

  def format_field_names(fieldset)
    sort_fields(fieldset).map do |fields|
      name, value = fields
      name = name.gsub(/^\d+_/, '').gsub(/_+/, ' ')

      [ name, value ]
    end
  end

  def sort_fields(fieldset)
    fieldset.sort_by do |fields|
      fields[0][/^\d+/].to_i
    end
  end
end
