# HHD Shopping Cart

This plugin will provide you with a generator and some helper methods for creating a shopping cart.


## Example

  $ ./script/generate hhd_shopping_cart gogoshoppingcart

  # app/models/book.rb
  class Book << ActiveRecord::Base
    acts_as_purchasable :name => :title, :price => :points
  end

  # app/views/books/show.html.erb
  <% purchasable_form_for @book.to_purchase do |f| %>
    <%= f.text_field :quantity %>
    <%= f.submit "Add to cart" %>
  <% end %>

  # app/controllers/admin_controller.rb
  def cms_nav
    [
      ["Orders", [Admin::OrdersController]],
      Admin::AdminsController
    ]
  end


## Gochas

1. You must have a route for your purchasable item. Following on from the
example above you should have a route like "map.resources :books" that makes
"books_path" available in your views.

2. The orders admin area will not appear in the navigation unless you've added
it to the cms_nav.

3. After generating the shopping cart you must migrate your database.

4. You've got to type something after the generator or you'll just see the
documentation. The generator doesn't actually use any of it's arguments, it's
just a requirement of rails.


## Extensions

Members Area:

  - Add code to pre-populate the addresses into /order/shipping_address
  - Add code to pre-populate the email address into /order
  - Add a belongs_to :member/has_many :orders relationship
  - Create Admin::MembersController
  - Add the user column into Admin::MembersController

Variable shipping:
  
  - Add fields for selecting shipping method on /order/shipping_address

Hosted payment gateway:

  - Add hidden fields describing the order to /order
  - Post from /order to the payment gateway

API based payment gateway:

  - Add a fields collecting the credit card information to
    /order/billing_address
  - Make the API call from OrdersController#create there, making sure to dispose
    of any sensitive information asap.

