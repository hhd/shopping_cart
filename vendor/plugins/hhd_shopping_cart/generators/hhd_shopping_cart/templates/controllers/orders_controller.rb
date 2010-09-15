class OrdersController < ApplicationController
  before_filter :find_order, :except => [:thankyou]

  def create
    @order.email = params[:order][:email]
    @order.placed = DateTime.now

    if @order.save
      CartMailer.deliver_thankyou(@order)
      session[:order_id] = nil
      redirect_to :action => "thankyou"
    else
      render :action => "show"
    end
  end

  def thankyou
  end

 protected

  def find_order
    @order = Order.find(session[:order_id])
  end

end
