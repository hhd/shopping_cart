class CreateShoppingCart < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string   :notes
      t.integer  :billing_address_id
      t.integer  :shipping_address_id
      t.datetime :placed

      t.timestamps
    end

    create_table :purchases do |t|
      t.string  :name
      t.float   :price
      t.integer :quantity
      t.integer :purchasable_id
      t.string  :purchasable_type
      t.integer :order_id

      t.timestamps
    end

    create_table :addresses do |t|
      t.string :name
      t.string :line_one
      t.string :line_two
      t.string :suburb
      t.string :state
      t.string :post_code
      t.string :country
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
    drop_table :purchases
    drop_table :addresses
  end
end
