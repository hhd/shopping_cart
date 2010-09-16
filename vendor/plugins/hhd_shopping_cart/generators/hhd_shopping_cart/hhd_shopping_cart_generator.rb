class HhdShoppingCartGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory "app/controllers"
        m.file "controllers/billing_addresses_controller.rb", "app/controllers/billing_addresses_controller.rb"
        m.file "controllers/orders_controller.rb", "app/controllers/orders_controller.rb"
        m.file "controllers/purchases_controller.rb", "app/controllers/purchases_controller.rb"
        m.file "controllers/shipping_addresses_controller.rb", "app/controllers/shipping_addresses_controller.rb"

        m.directory "app/controllers/admin"
          m.file "controllers/admin/billing_addresses_controller.rb", "app/controllers/admin/billing_addresses_controller.rb"
          m.file "controllers/admin/orders_controller.rb", "app/controllers/admin/orders_controller.rb"
          m.file "controllers/admin/purchases_controller.rb", "app/controllers/admin/purchases_controller.rb"
          m.file "controllers/admin/shipping_addresses_controller.rb", "app/controllers/admin/shipping_addresses_controller.rb"

      m.directory "app/models"
        m.file "models/address.rb", "app/models/address.rb"
        m.file "models/cart_mailer.rb", "app/models/cart_mailer.rb"
        m.file "models/order.rb", "app/models/order.rb"
        m.file "models/purchase.rb", "app/models/purchase.rb"

      m.directory "app/views"
        m.directory "app/views/billing_addresses"
          m.file "views/billing_addresses/show.html.erb", "app/views/billing_addresses/show.html.erb"

        m.directory "app/views/cart_mailer"
          m.file "views/cart_mailer/thankyou.erb", "app/views/cart_mailer/thankyou.erb"

        m.directory "app/views/orders"
          m.file "views/orders/show.html.erb", "app/views/orders/show.html.erb"
          m.file "views/orders/thankyou.html.erb", "app/views/orders/thankyou.html.erb"

        m.directory "app/views/purchases"
          m.file "views/purchases/create.html.erb", "app/views/purchases/create.html.erb"
          m.file "views/purchases/index.html.erb", "app/views/purchases/index.html.erb"

        m.directory "app/views/shipping_addresses"
          m.file "views/shipping_addresses/show.html.erb", "app/views/shipping_addresses/show.html.erb"

      m.directory "config/initializers"
        m.file "initializers/countries.rb", "config/initializers/countries.rb"

      m.directory "db/migrate"
        m.file "migrate/20100902031337_create_shopping_cart.rb", "db/migrate/20100902031337_create_shopping_cart.rb"
      
      insert_routes <<-ROUTES
  map.namespace :admin do |admin|
    admin.resources :addresses, :active_scaffold => true
    admin.resources :purchases, :active_scaffold => true
    admin.resources :orders, :active_scaffold => true
  end
      ROUTES

      insert_routes <<-ROUTES
  map.resource :order do |order|
    order.resources :purchases
    order.resource :shipping_address
    order.resource :billing_address
  end
      ROUTES

      puts "You will need to add the orders admin area into the navigation yourself."
    end
  end

  def insert_routes(routes)
    sentinel = 'ActionController::Routing::Routes.draw do |map|'
    
    logger.route routes
    unless options[:pretend]
      gsub_file 'config/routes.rb', /(#{Regexp.escape(sentinel)})/mi do |match|
        "#{match}\n#{routes}\n"
      end
    end
  end

  def gsub_file(relative_destination, regexp, *args, &block)
    path = destination_path(relative_destination)
    content = File.read(path).gsub(regexp, *args, &block)
    File.open(path, 'wb') { |file| file.write(content) }
  end

end
