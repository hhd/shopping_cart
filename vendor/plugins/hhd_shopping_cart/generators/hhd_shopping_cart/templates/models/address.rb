class Address < ActiveRecord::Base
  validates_presence_of :name, :line_one, :suburb, :state, :post_code, :country
end
