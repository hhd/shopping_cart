class Admin::<%= class_name %>Controller < AdminController

  active_scaffold :<%= file_name.singularize %> do |config|
    config.list.label = "<%= class_name.titleize %>"
    config.create.label = "Create <%= class_name.singularize.titleize %>"

    config.columns = []

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
