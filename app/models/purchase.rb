class Purchase < ActiveRecord::Base
  belongs_to :purchasable, :polymorphic => true
  belongs_to :order
end
