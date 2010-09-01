class Camera < ActiveRecord::Base
  def name
    "#{brand} #{model}"
  end
end
