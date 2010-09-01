class Admin::CamerasController < AdminController

  active_scaffold :camera do |config|
    config.list.label = "Cameras"
    config.create.label = "Create Camera"

    config.columns = [:brand, :model, :price, :description]
    config.list.columns.exclude [:description]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
