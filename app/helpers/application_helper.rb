# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def show_cart?
    not session[:order_id].nil?
  end
end
