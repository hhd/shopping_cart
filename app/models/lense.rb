class Lense < ActiveRecord::Base
  def name
    "#{brand} #{focal_length}mm f/#{apature} #{features}"
  end
end
