class Address < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :name, :line_one, :suburb, :post_code, :country
end
