class Admin::BooksController < AdminController

  active_scaffold :book do |config|
    config.list.label = "Books"
    config.create.label = "Create Book"

    config.columns = [:name, :price, :description]
    config.list.columns.exclude [:description]

    config.columns[:updated_at].options = {:format => "%d/%m/%Y %I:%M%p"}
  end 

end
