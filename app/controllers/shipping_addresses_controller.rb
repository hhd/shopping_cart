class ShippingAddressesController < ApplicationController
  before_filter :find_order

  def show
    @order.shipping_address ||= Address.new
  end

  def create
    @order.build_shipping_address(params[:address])
    @order.build_billing_address(params[:address]) if params[:use_for_billing]

    if @order.save
      if params[:use_for_billing]
        redirect_to order_path
      else
        redirect_to order_billing_address_path
      end
    else
      render :action => "show"
    end
  end

  def update
    if @order.shipping_address.update_attributes(params[:address])
      if params[:use_for_billing] and @order.billing_address.update_attributes(params[:address])
        redirect_to order_path
      else
        redirect_to order_billing_address_path
      end
    else
      render :action => "show"
    end
  end

 protected

  def find_order
    @order = Order.find(session[:order_id])
  end
end
