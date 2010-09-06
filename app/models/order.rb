class Order < ActiveRecord::Base
  has_many :purchases
end
