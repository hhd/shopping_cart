class Order < ActiveRecord::Base
  has_many :purchases
  belongs_to :billing_address,  :class_name => "Address", :foreign_key => :billing_address_id
  belongs_to :shipping_address, :class_name => "Address", :foreign_key => :shipping_address_id

  def total
    self.purchases.reduce(0){|t, p| t + p.sub_total }
  end
end
