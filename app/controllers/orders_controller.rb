class OrdersController < ApplicationController
  before_filter :create_or_find_order

  def shipping
  end

 protected

  def create_or_find_order
    if session[:order_id].nil? 
      @order = Order.create
      session[:order_id] = @order.id
    else
      @order = Order.find(session[:order_id])
    end
  end

end
