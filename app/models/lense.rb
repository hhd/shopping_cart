class Lense < ActiveRecord::Base
  def name
    "#{focal_length}mm f/#{apature} #{features}"
  end
end
