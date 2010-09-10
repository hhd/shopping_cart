class OrdersController < ApplicationController
  before_filter :find_order, :except => [:thankyou]

  def create
    @order.placed = DateTime.now
    @order.save
    session[:order_id] = nil
    redirect_to :action => "thankyou"
  end

  def thankyou
    render :text => "thankyou"
  end

 protected

  def find_order
    @order = Order.find(session[:order_id])
  end

end
