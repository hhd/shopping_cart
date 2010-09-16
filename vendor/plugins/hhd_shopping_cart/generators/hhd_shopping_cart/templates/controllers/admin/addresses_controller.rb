class Admin::AddressesController < AdminController

  active_scaffold :address do |config|
    config.subform.layout = :vertical
    config.list.label = "Addresses"
    config.create.label = "Create Address"

    config.columns = [:name, :line_one, :line_two, :suburb, :state, :post_code, :country]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
