class CamerasController < ApplicationController
  def index
    @cameras = Camera.all :order => "price ASC"
  end

  def show
    @camera = Camera.find params[:id]
  end

end
