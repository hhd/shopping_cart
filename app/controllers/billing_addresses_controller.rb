class BillingAddressesController < ApplicationController

  def create
    order = Order.find(session[:order_id])
    order.build_billing_address(params[:address])

    if order.save
      redirect_to billing_order_path
    else
      render :template => "orders/billing"
    end
  end

  def update
    address = Address.find(params[:id])

    if address.update_attributes(params[:address])
      redirect_to billing_order_path
    else
      render :template => "orders/billing"
    end
  end

end
