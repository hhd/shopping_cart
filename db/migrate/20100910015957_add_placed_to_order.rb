class AddPlacedToOrder < ActiveRecord::Migration
  def self.up
    add_column :orders, :placed, :datetime
  end

  def self.down
    remove_column :orders, :placed
  end
end
