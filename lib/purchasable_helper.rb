module PurchasableHelper

  def purchasable_form_for( purchasable, *remainder )
    form_for( [:order, purchasable], *remainder ) do |f|
      concat f.hidden_field(:name)
      concat f.hidden_field(:price)
      concat f.hidden_field(:quantity)
      concat f.hidden_field(:purchasable_id)
      concat f.hidden_field(:purchasable_type)
      yield f
    end
  end

end
