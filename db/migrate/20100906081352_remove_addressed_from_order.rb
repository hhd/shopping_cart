class RemoveAddressedFromOrder < ActiveRecord::Migration
  def self.up
    remove_column :orders, :shipping_address_id
    remove_column :orders, :billing_address_id
  end

  def self.down
    add_column :orders, :billing_address_id, :integer
    add_column :orders, :shipping_address_id, :integer
  end
end
