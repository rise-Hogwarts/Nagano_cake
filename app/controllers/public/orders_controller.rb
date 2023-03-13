class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def confirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      #orderに送られたselect_addressの値が(1)だったときのif文
    @order.postal_code = Address.find(params[:order][:address_id]).postal_code
    @order.address = Address.find(params[:order][:address_id]).address
    @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:select_address] == "2"

    else
      render :new
    end
    @total = 0
  end

  def complete
  end

  def create
  end

  def index
    @orders = Order.all
  end

  def show
  end


  private
   def order_params
     params.require(:order).permit(:payment_method, :postal_code, :address, :name)
   end

end
