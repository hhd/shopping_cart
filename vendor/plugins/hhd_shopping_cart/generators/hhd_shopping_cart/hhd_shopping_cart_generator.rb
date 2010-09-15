class HhdShoppingCartGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory "app/controllers"
        m.file "controllers/billing_addresses_controller.rb", "app/controllers/billing_addresses_controller.rb"
        m.file "controllers/orders_controller.rb", "app/controllers/orders_controller.rb"
        m.file "controllers/purchases_controller.rb", "app/controllers/purchases_controller.rb"
        m.file "controllers/shipping_addresses_controller.rb", "app/controllers/shipping_addresses_controller.rb"

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
          m.file "views/orders/show.html.erb", "app/views/orders/show.html.erb"

      m.directory "db/migrate"
        m.file "migrate/20100902031337_create_shopping_cart.rb", "db/migrations/20100902031337_create_shopping_cart.rb"
    end
  end
end
