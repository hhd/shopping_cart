class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :name
      t.string :line_one
      t.string :line_two
      t.string :suburb
      t.string :state
      t.string :post_code
      t.string :country

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end
