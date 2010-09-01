class CreateLenses < ActiveRecord::Migration
  def self.up
    create_table :lenses do |t|
      t.string :apature
      t.string :focal_length
      t.string :features
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :lenses
  end
end
