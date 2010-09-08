class ShippingAddressesController < ApplicationController

  def show
    @order = Order.find(session[:order_id])
    @order.shipping_address ||= Address.new
  end

  def create
    @order = Order.find(session[:order_id])
    @order.build_shipping_address(params[:address])

    if @order.shipping_address.save and @order.save
      redirect_to order_billing_address_path
    else
      render :action => "show"
    end
  end

  def update
    @order = Order.find(session[:order_id])

    if @order.shipping_address.update_attributes(params[:address])
      redirect_to order_billing_address_path
    else
      render :action => "show"
    end
  end
end
