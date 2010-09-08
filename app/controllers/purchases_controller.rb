class PurchasesController < ApplicationController

  before_filter :create_or_find_order

  def index
  end

  # If the purchase has already been made then add to the quantity
  # otherwise create the purchase
  def create
    purchase = @order.purchases.first(:conditions => {
      :purchasable_id   => params[:purchase][:purchasable_id],
      :purchasable_type => params[:purchase][:purchasable_type]
    })

    if purchase
      purchase.quantity += params[:purchase][:quantity].to_i
      purchase.save
    else
      @order.purchases << Purchase.new(params[:purchase])
      @order.save
    end

    if params[:redirect_to]
      flash[:success] = %{#{params[:purchase][:name]} has been added to your order. <a href="/order/purchases">Proceed to checkout</a>.}
      redirect_to params[:redirect_to]
    else
      redirect_to order_purchases_path
    end
  end

  def destroy
    @order.purchases.find(params[:id]).destroy
    redirect_to order_purchases_path
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
