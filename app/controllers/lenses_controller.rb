class LensesController < ApplicationController
  def index
    @lenses = Lense.all :order => "price ASC"
  end

  def show
    @lense = Lense.find params[:id]
  end

end
