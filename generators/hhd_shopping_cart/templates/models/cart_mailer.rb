class CartMailer < ActionMailer::Base
  

  def thankyou(order, sent_at = Time.now)
    subject    "Your purchase receipt"
    recipients order.shipping_address.email
    from       HHD::Config.admin_email
    sent_on    sent_at
    
    body       :order => order
  end

end
