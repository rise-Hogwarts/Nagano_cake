class Admin::OrdersController < ApplicationController

  def show
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    # @order_details = OrderDetail.where(order_id: @order.id)
    # if @order.update(order_params)
    #   @ordered.order_details.update_all(production_status: 1) if @order.order_status == 1
    # end
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end


  private
   def order_params
     params.require(:order).permit(:order_status)
   end


end
