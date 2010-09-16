class Admin::OrdersController < AdminController

  active_scaffold :order do |config|
    config.list.label = "Orders"
    config.create.label = "Create Order"

    config.columns = [:id, :email, :placed, :billing_address, :shipping_address, :purchases, :notes]
    config.list.columns.exclude [:notes]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
    config.columns[:placed].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
