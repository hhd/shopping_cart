class CartMailer < ActionMailer::Base
  

  def thankyou(order, sent_at = Time.now)
    subject    "Your purchase receipt"
    recipients order.email
    from       "logan@hhd.com.au"
    sent_on    sent_at
    
    body       :order => order
  end

end
