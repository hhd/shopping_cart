class CreatePurchases < ActiveRecord::Migration
  def self.up
    create_table :purchases do |t|
      t.string :name
      t.float :price
      t.integer :quantity
      t.integer :purchasable_id
      t.string :purchasable_type

      t.timestamps
    end
  end

  def self.down
    drop_table :purchases
  end
end
