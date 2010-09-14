class Lense < ActiveRecord::Base

  acts_as_purchasable

  def name
    "#{brand} #{focal_length}mm f/#{apature} #{features}"
  end

end
