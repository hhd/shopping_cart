class AddressesController < ApplicationController

  def create
    order = Order.find(session[:order_id])
    order.build_shipping_address(params[:address])

    if order.save
      redirect_to billing_order_path
    else
      render :template => "orders/shipping"
    end
  end

  def update
    address = Address.find(params[:id])

    if address.update_attributes(params[:address])
      redirect_to billing_order_path
    else
      render :template => "orders/shipping"
    end
  end

end
