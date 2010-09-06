class Order < ActiveRecord::Base
  has_many :purchases
  has_one :billing_address,  :class_name => "Address"
  has_one :shipping_address, :class_name => "Address"

  def total
    self.purchases.reduce(0){|t, p| t + p.sub_total }
  end
end
