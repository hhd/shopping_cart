class AddBrandToLenses < ActiveRecord::Migration
  def self.up
    add_column :lenses, :brand, :string
  end

  def self.down
    remove_column :lenses, :brand
  end
end
