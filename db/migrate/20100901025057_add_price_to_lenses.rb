class AddPriceToLenses < ActiveRecord::Migration
  def self.up
    add_column :lenses, :price, :float
  end

  def self.down
    remove_column :lenses, :price
  end
end
