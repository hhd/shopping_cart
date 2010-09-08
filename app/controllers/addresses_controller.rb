class AddressesController < ApplicationController

  def create
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
