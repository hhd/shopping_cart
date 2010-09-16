class Admin::PurchasesController < AdminController

  active_scaffold :purchase do |config|
    config.list.label = "Purchases"
    config.create.label = "Create Purchase"

    config.columns = [:name, :price, :quantity, :order]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
