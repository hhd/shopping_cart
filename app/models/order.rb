class Order < ActiveRecord::Base
  has_many :purchases

  def total
    self.purchases.reduce(0){|t, p| t + p.sub_total }
  end
end
