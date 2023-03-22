class Admin::HomesController < ApplicationController

  def top
    @orders = Order.page(params[:page]).per(10)
    @total = 0
  end

end
