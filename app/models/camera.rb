class Camera < ActiveRecord::Base
  acts_as_purchasable :name => :name, :price => :price

  def name
    "#{brand} #{model}"
  end
end
