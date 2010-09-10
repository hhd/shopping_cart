class ShippingAddressesController < ApplicationController
  before_filter :find_order

  def show
    @order.shipping_address ||= Address.new
  end

  def create
    @order.build_shipping_address(params[:address])

    if @order.shipping_address.save and @order.save
      redirect_to order_billing_address_path
    else
      render :action => "show"
    end
  end

  def update
    if @order.shipping_address.update_attributes(params[:address])
      redirect_to order_billing_address_path
    else
      render :action => "show"
    end
  end

 protected

  def find_order
    @order = Order.find(session[:order_id])
  end
end
