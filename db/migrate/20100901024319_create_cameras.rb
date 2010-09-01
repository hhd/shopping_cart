class CreateCameras < ActiveRecord::Migration
  def self.up
    create_table :cameras do |t|
      t.string :model
      t.float :price
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :cameras
  end
end
