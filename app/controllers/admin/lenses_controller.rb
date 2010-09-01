class Admin::LensesController < AdminController

  active_scaffold :lense do |config|
    config.list.label = "Lenses"
    config.create.label = "Create Lense"

    config.columns = [:apature, :focal_length, :price, :features, :description]
    config.list.columns.exclude [:description]
    config.show.columns.add [:name]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
