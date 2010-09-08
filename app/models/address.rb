class Address < ActiveRecord::Base
  validates_presence_of :name, :line_one, :suburb, :post_code, :country
end
