class AddOrderIdToPurchases < ActiveRecord::Migration
  def self.up
    add_column :purchases, :order_id, :integer
  end

  def self.down
    remove_column :purchases, :order_id
  end
end
