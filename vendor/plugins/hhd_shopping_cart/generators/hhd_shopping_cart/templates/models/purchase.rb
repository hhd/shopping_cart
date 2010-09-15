class Purchase < ActiveRecord::Base
  belongs_to :purchasable, :polymorphic => true
  belongs_to :order

  def sub_total
    self.quantity * self.price
  end
end
