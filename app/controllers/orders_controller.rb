class OrdersController < ApplicationController
  before_filter :create_or_find_order

  def shipping
    @order.shipping_address ||= Address.new
  end

  def billing
    @order.billing_address ||= Address.new
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
