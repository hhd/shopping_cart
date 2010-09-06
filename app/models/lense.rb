class Lense < ActiveRecord::Base
  has_many :purchases, :as => :purchasable

  def name
    "#{brand} #{focal_length}mm f/#{apature} #{features}"
  end

  def purchase( quantity = 1 )
    Purchase.new :name             => self.name,
                 :price            => self.price,
                 :quantity         => quantity,
                 :purchasable_id   => self.id,
                 :purchasable_type => self.class
  end
end
