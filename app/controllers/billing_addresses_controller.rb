class BillingAddressesController < ApplicationController
  before_filter :find_order

  def show
    @order.billing_address ||= Address.new
  end

  def create
    @order.build_billing_address(params[:address])

    if @order.billing_address.save and @order.save
      redirect_to order_path
    else
      render :action => "show"
    end
  end

  def update
    if @order.billing_address.update_attributes(params[:address])
      redirect_to order_path
    else
      render :action => "show"
    end
  end

 protected

  def find_order
    @order = Order.find(session[:order_id])
  end

end
