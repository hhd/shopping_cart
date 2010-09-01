class AddBrandToCameras < ActiveRecord::Migration
  def self.up
    add_column :cameras, :brand, :string
  end

  def self.down
    remove_column :cameras, :brand
  end
end
